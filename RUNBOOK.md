# Runbook — priceticker (Brazilian deal intelligence)

## Local development
- PHP 8.4 + MySQL 8.2 (podman): see Phase 0/1 verification commands in PROGRESS.md.
- `cp .env.example-dev .env && php artisan key:generate`
- `php artisan migrate --force && php artisan buddy:create-stores brazil`
- `npm install && npm run build`
- `php artisan serve` (or `docker compose up`)

## Tests
- PHP: `vendor/bin/pest` (requires MySQL `tests_db`), `vendor/bin/phpstan analyse`, `vendor/bin/pint`.
- Python: `cd tools && python -m unittest discover br_deals/tests -v`.
- Full PHP suite has been green on PHP 8.4 / MySQL 8.2 (1 skipped); the mobile
  API routes are covered by `RoutePermissionsTest` (every Sanctum route must
  carry an `ability:` middleware).

## Deploy on Render (current production path)

The service is built by Render from this repository's `Dockerfile`; nothing is
built on the laptop. State lives in Supabase Postgres, so the free plan's
ephemeral disk does not lose watches or price history.

### One-time setup
1. Create the database schema (only once):
   ```sql
   create schema if not exists priceticker;
   ```
   The app also does this on first boot when the connection user may create
   schemas. `DB_SEARCH_PATH=priceticker` keeps its tables out of the shared
   project's `public` schema.
2. Copy the deploy credentials into gitignored files:
   - `.env.render`: `RENDER_API_KEY`, `APP_KEY`, `APP_USER_EMAIL`,
     `APP_USER_PASSWORD`
   - `.env.supabase`: `DATABASE_URL` (Supabase **session pooler**, port 5432)
   - `.env.resend`: `RESEND_API_KEY`, `MAIL_FROM`
   Generate `APP_KEY` once and keep it forever: changing it invalidates
   sessions and encrypted values. The deploy script generates a missing key
   and admin password into `.env.render` (mode 0600).
3. Deploy:
   ```shell
   python scripts/render_deploy.py --check
   python scripts/render_deploy.py --yes
   ```
   Live URL: <https://priceticker.onrender.com>. Admin: `/admin`, with the
   email/password from `.env.render`.

### Every later deploy
```shell
python scripts/render_deploy.py --yes
```
The script merges the service environment by default (dashboard-only values
survive); `--replace-env` is the deliberate reset. It triggers a deploy, watches
it to `live`, and prints the build log if the build fails.

### Operating notes
- Health check: `/up` (app-only; it does not fail when Postgres has a blip).
- One instance only: Apache, cron and the queue worker share one container, so
  two instances would run the scheduler twice.
- First boot applies all migrations, creates the Brazilian stores and the
  admin user. Later boots only apply new migrations.
- `APP_KEY`, `DATABASE_URL` and the admin password are Render secrets; they are
  never in `render.yaml` (which uses `sync: false` placeholders).
- The entrypoint honours Render's `$PORT`; do not hard-code 8080 in the
  dashboard. The image defaults to 8080 only when `PORT` is absent.
- The image runs `php artisan optimize` at boot. Route caching works because
  the root route is a controller, not a closure.
- Render logs include Apache access/error output and the Laravel `stderr`
  channel; `docker/php/start-app.sh` deliberately does not print the
  environment.

## Deploy fallback: Fly.io
- `fly launch --copy-config --now` (uses `fly.toml`, region gru); create volume
  `fly volumes create data`; set secrets via `fly secrets set`.
- Fly keeps `/data` on a volume; the app itself is stateless now, so the volume
  is only useful for local storage/uploads.

## Web (Flutter)
- Live demo: https://zgabrielr1.github.io/priceticker/
- Rebuild with backend URL: `flutter build web --dart-define=API_BASE_URL=https://priceticker.onrender.com`
- APK release: https://github.com/zGabrielR1/priceticker/releases/tag/v0.1.0

## Backups
- Postgres: use Supabase's scheduled backups (or `pg_dump` the `priceticker`
  schema). The database is the only durable state.
- Uploaded media lives in `storage/app/public` inside the container and is
  ephemeral on Render's free plan; use object storage before relying on uploads.

## Notes
- Python adapters/sinks live in `tools/br_deals/` and push to `/api/v1/*` once
  wired (HttpSink fail-safe until then).
- ntfy remains a notification channel; FCM is used for mobile push.
- Mail uses Resend when `RESEND_API_KEY` is present; otherwise Laravel's `log`
  mailer keeps the app usable without credentials.
