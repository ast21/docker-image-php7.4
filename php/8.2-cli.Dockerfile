ARG PHP_VERSION=8.2.5
FROM php:${PHP_VERSION}-cli

ARG COMPOSER_VERSION=2.5.5

# Install dependencies
RUN apt-get update && apt-get install -y \
        git zip unzip libpq-dev libzip-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev libwebp-dev \
#    && docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-webp-dir=/usr \  # php 7.3 and below
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) bcmath pdo_mysql pdo_pgsql gd zip exif sockets pcntl \
    && apt-get clean && apt-get autoclean

# Install composer
RUN curl -sS https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer
