# syntax=docker/dockerfile:1

# Tailwind reads Filament's preset from vendor/, so the frontend stage needs
# the PHP dependencies before it can build. This vendor is only for the build:
# the runtime image installs its own with the correct PHP version.
FROM docker.io/library/composer:2 AS vendor

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader \
    --ignore-platform-reqs --no-interaction --no-progress --prefer-dist


# Frontend assets are built with a current Node. The PHP image ships Node 18
# on bookworm, which is already below several Vite dependencies' engine floor;
# a separate stage keeps the build reproducible without putting Node in the
# runtime image.
FROM docker.io/library/node:22-bookworm-slim AS frontend

WORKDIR /app

COPY --from=vendor /app/vendor ./vendor
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY resources ./resources
COPY public ./public
COPY vite.config.js postcss.config.js tailwind.config.js ./
RUN npm run build


FROM php:8.4-apache-bookworm

ARG APP_VERSION=production

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    APP_ENV=production \
    APP_DEBUG=false \
    APP_VERSION=${APP_VERSION}

WORKDIR /app

# OS deps + PHP extensions (mirrors docker/base.dockerfile). Apache gets
# rewrite (Laravel's front controller) and headers (the security config).
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        cron supervisor zip unzip \
        libzip-dev zlib1g-dev libicu-dev libpq-dev \
        default-mysql-client netcat-traditional \
        less nano \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install exif pcntl posix mysqli pdo pdo_mysql pdo_pgsql zip intl \
    && a2enmod rewrite headers

# Composer
COPY --from=composer/composer:2-bin /composer /usr/bin/composer

# App source
COPY . /app

# Storage dirs needed by artisan package:discover. The runtime entrypoint
# generates APP_KEY on first boot if the platform did not provide one, so no
# key is baked into the image.
RUN mkdir -p storage/framework/sessions storage/framework/views storage/framework/cache/data storage/framework/testing storage/logs storage/app/public bootstrap/cache \
    && php -r "file_exists('.env') || copy('.env.example', '.env');"

# Install PHP deps
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress --prefer-dist

# Frontend assets from the Node stage
COPY --from=frontend /app/public/build /app/public/build

# Apache: serve /app/public directly so Laravel's .htaccess is honoured.
COPY docker/php/apache-vhost.conf /etc/apache2/sites-available/000-default.conf
COPY docker/php/apache-security.conf /etc/apache2/conf-enabled/zz-priceticker-security.conf
COPY docker/php/schedule-cron /etc/cron.d/schedule-cron
RUN chmod 0644 /etc/cron.d/schedule-cron

# Storage dirs + permissions
RUN mkdir -p storage/framework/sessions storage/framework/views storage/framework/testing storage/logs storage/app/public \
    && chown -R www-data:www-data /app \
    && rm -rf /var/www/html && ln -s /app/public /var/www/html \
    && sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
    && sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-enabled/000-default.conf

# Entrypoint + supervisor config
COPY docker/php/start-app.sh /start-app.sh
COPY docker/php/start-cron.sh /start-cron.sh
COPY docker/php/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/php/php.ini /usr/local/etc/php/conf.d/zzz-php-overrides.ini
RUN chmod +x /start-app.sh /start-cron.sh

EXPOSE 8080

CMD ["/start-app.sh"]
