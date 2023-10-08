ARG PHP_VERSION=8.2.10
ARG ALPINE_VERSION=3.18
ARG ROADRUNNER_VERSION=2023.3.0

FROM ghcr.io/roadrunner-server/roadrunner:${ROADRUNNER_VERSION} AS roadrunner
FROM php:${PHP_VERSION}-cli-alpine${ALPINE_VERSION}

# Install dependencies
RUN apk --no-cache add zip unzip libpq-dev libzip-dev libpng-dev linux-headers
RUN docker-php-ext-install -j$(nproc) bcmath pdo_mysql pdo_pgsql gd zip exif sockets pcntl

# Install composer
ARG COMPOSER_VERSION=2.6.5
RUN curl -sS https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Install roadrunner
COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr

# Open port 8000
EXPOSE 8000

# Start Laravel with Octane
WORKDIR /var/www/html
CMD php artisan octane:start --host=0.0.0.0