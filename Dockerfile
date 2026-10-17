# syntax=docker/dockerfile:1
FROM php:8.4-apache-bookworm

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    APP_ENV=production \
    APP_DEBUG=false

WORKDIR /app

# OS deps + PHP extensions (mirrors docker/base.dockerfile)
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        cron supervisor zip unzip \
        libzip-dev zlib1g-dev libicu-dev libpq-dev \
        default-mysql-client netcat-traditional nodejs npm \
        less nano \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install exif pcntl posix mysqli pdo pdo_mysql pdo_pgsql zip intl

# Composer
COPY --from=composer/composer:2-bin /composer /usr/bin/composer

# App source
COPY . /app

# Storage dirs needed by artisan package:discover
RUN mkdir -p storage/framework/sessions storage/framework/views storage/framework/cache/data storage/framework/testing storage/logs storage/app/public bootstrap/cache \
    && cp .env.example .env 2>/dev/null || true \
    && php -r "file_exists('.env') || copy('.env.example', '.env');" \
    && php artisan key:generate --force >/dev/null 2>&1 || true

# Install PHP deps
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Frontend assets
RUN npm install --no-audit --no-fund && npm run build

# Storage dirs + permissions
RUN mkdir -p storage/framework/sessions storage/framework/views storage/framework/testing storage/logs storage/app/public \
    && chown -R www-data:www-data /app \
    && rm -rf /var/www/html && ln -s /app/public /var/www/html \
    && sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
    && sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-enabled/000-default.conf \
    && a2enmod rewrite

# Entrypoint + supervisor config
COPY docker/php/start-app.sh /start-app.sh
COPY docker/php/start-cron.sh /start-cron.sh
COPY docker/php/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/php/php.ini /usr/local/etc/php/conf.d/zzz-php-overrides.ini
RUN chmod +x /start-app.sh /start-cron.sh

EXPOSE 8080

CMD ["/start-app.sh"]
