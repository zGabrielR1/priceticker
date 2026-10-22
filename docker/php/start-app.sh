#!/bin/bash
#
# Container entrypoint: make the writable paths, wait for the database, apply
# migrations, warm the caches and hand over to supervisor (Apache + cron +
# queue worker).
#
# Everything here is idempotent: a redeploy runs the same steps against a
# database that already has data, and `buddy:init-db` only migrates in that
# case. The one destructive path (`migrate:fresh`) is inside InitDatabase and
# only runs when the schema has no migrations table at all.
set -euo pipefail

cd /app

# Render injects configuration as real environment variables. The `.env` in
# the image is only a build-time fallback (and holds a throwaway APP_KEY), so
# never overwrite an existing file and never print the environment.
if [ ! -s .env ]; then
    cp .env.example .env
fi

if [ -z "${APP_KEY:-}" ] && ! grep -q '^APP_KEY=base64:' .env 2>/dev/null; then
    php artisan key:generate --force >/dev/null
fi

mkdir -p \
    storage/framework/sessions \
    storage/framework/views \
    storage/framework/cache/data \
    storage/framework/testing \
    storage/logs \
    storage/app/public \
    bootstrap/cache

chown -R www-data:www-data storage bootstrap/cache 2>/dev/null || true
chmod -R ug+rwX storage bootstrap/cache

php artisan storage:link --force >/dev/null 2>&1 || true

# Clear only the caches that do not touch the database yet: cache:clear would
# query the cache table before the first migration has created it.
php artisan config:clear >/dev/null
php artisan route:clear >/dev/null
php artisan view:clear >/dev/null
php artisan event:clear >/dev/null

# Wait for the database. The host can come from DB_HOST or from a connection
# URL (DATABASE_URL is what Supabase/Render hand out; DB_URL is Laravel's own
# spelling). `nc` is used instead of a PDO probe so this stays cheap while the
# managed database is still starting.
if [ "${DB_CONNECTION:-mysql}" != "sqlite" ]; then
    if [ -z "${DB_HOST:-}" ] && [ -n "${DB_URL:-${DATABASE_URL:-}}" ]; then
        read -r DB_HOST DB_PORT <<EOF
$(php -r '
$url = getenv("DB_URL") ?: getenv("DATABASE_URL");
$parts = parse_url((string) $url);
$scheme = strtolower((string) ($parts["scheme"] ?? "pgsql"));
$defaultPort = in_array($scheme, ["mysql", "mariadb"], true) ? 3306 : 5432;
echo ($parts["host"] ?? "")." ".($parts["port"] ?? $defaultPort);
')
EOF
    fi

    DB_HOST="${DB_HOST:-database}"
    DB_PORT="${DB_PORT:-$([ "${DB_CONNECTION:-mysql}" = "pgsql" ] && echo 5432 || echo 3306)}"
    attempts=0
    until nc -z "$DB_HOST" "$DB_PORT" 2>/dev/null; do
        attempts=$((attempts + 1))
        if [ "$attempts" -ge 60 ]; then
            echo "Database at ${DB_HOST}:${DB_PORT} did not become reachable" >&2
            exit 1
        fi
        echo "Database unavailable at ${DB_HOST}:${DB_PORT} - retrying in 2s" >&2
        sleep 2
    done
fi

# Migrate and, on a brand-new schema, create the configured stores and admin
# user (APP_USER_EMAIL / APP_USER_PASSWORD).
php artisan buddy:init-db

# The database is ready now, so the data-backed caches can be cleared/warmed.
php artisan cache:clear >/dev/null
php artisan optimize
php artisan icons:cache >/dev/null
php artisan filament:optimize >/dev/null 2>&1 || true

# Rebuilding the price cache on every boot is O(products) and unnecessary:
# the columns are already in the database. Opt in only when a migration
# changed their shape.
if [ "${RUN_PRICE_CACHE_ON_BOOT:-0}" = "1" ]; then
    php artisan buddy:regenerate-price-cache
fi

# Lando installs xdebug on demand; production images do not have pecl.
if [ -n "${LANDO_INFO:-}" ] && command -v pecl >/dev/null 2>&1; then
    pecl install xdebug && docker-php-ext-enable xdebug
fi

# Render injects PORT and routes to it. The image defaults to 8080, but a
# platform-assigned port must win or the health check answers "connection
# refused". Rewrite both halves of Apache's listener at runtime.
APP_PORT="${PORT:-8080}"
sed -i -E "s/^Listen [0-9]+/Listen ${APP_PORT}/" /etc/apache2/ports.conf
sed -i -E "s/<VirtualHost \*:[0-9]+>/<VirtualHost *:${APP_PORT}>/" \
    /etc/apache2/sites-available/000-default.conf

exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
