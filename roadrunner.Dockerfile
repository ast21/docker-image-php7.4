ARG PHP_VERSION=8.1.5
ARG ROADRUNNER_VERSION=2.9.1

FROM ghcr.io/roadrunner-server/roadrunner:${ROADRUNNER_VERSION} AS roadrunner
FROM php:${PHP_VERSION}-cli

ARG COMPOSER_VERSION=2.3.5

# Install dependencies
RUN apt-get update && apt-get install -y \
        git zip unzip libpq-dev libzip-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev \
    && docker-php-ext-install -j$(nproc) bcmath pdo_mysql pdo_pgsql gd zip exif sockets pcntl \
    && apt-get clean && apt-get autoclean

# Install composer
RUN curl -sS https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Install roadrunner
COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr

# Open port 8000
EXPOSE 8000

# Start Laravel Octane
CMD ["php", "/var/www/html/artisan", "octane:start", "--host=0.0.0.0"]
