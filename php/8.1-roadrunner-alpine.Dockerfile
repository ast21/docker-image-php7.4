ARG PHP_VERSION=8.1.5
ARG ALPINE_VERSION=3.15
ARG ROADRUNNER_VERSION=2.9.1

FROM ghcr.io/roadrunner-server/roadrunner:${ROADRUNNER_VERSION} AS roadrunner
FROM php:${PHP_VERSION}-cli-alpine${ALPINE_VERSION}

# Install dependencies
RUN apk --no-cache add zip unzip libpq-dev libzip-dev libpng-dev
RUN docker-php-ext-install -j$(nproc) bcmath pdo_mysql pdo_pgsql gd zip exif sockets pcntl

# Install composer
ARG COMPOSER_VERSION=2.3.5
RUN curl -sS https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Install roadrunner
COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr

# Open port 8000
EXPOSE 8000

# Start Laravel 9 Octane
WORKDIR /var/www/html
CMD ["php", "artisan", "octane:start", "--host=0.0.0.0"]
