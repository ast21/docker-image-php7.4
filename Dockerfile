FROM php:7.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
        git zip unzip libpq-dev libzip-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev \
    && docker-php-ext-install -j$(nproc) bcmath pdo_mysql pdo_pgsql gd zip \
    && apt-get clean && apt-get autoclean

# Environments
ENV USER php
ENV COMPOSER_HOME /home/$USER/.composer

# Create user
RUN useradd --create-home --shell /bin/bash $USER

# Install composer with hirak/prestissimo
RUN curl -sS https://getcomposer.org/composer-stable.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer --no-interaction global require 'hirak/prestissimo' \
    && chown -R $USER:$USER /home/$USER/.composer

RUN chown -R $USER:$USER /var/www
USER php
WORKDIR /var/www
