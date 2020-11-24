FROM php:7.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
        git zip unzip libpq-dev libzip-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev \
    && docker-php-ext-install -j$(nproc) bcmath pdo_mysql pdo_pgsql gd zip exif \
    && apt-get clean && apt-get autoclean

# Environments
ENV USER php
ENV COMPOSER_VERSION 2.0.7

# Install composer
RUN curl -sS https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Create user
RUN useradd --create-home --shell /bin/bash $USER
RUN chown -R $USER:$USER /var/www
USER $USER
WORKDIR /var/www
