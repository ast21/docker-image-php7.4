# PHP-FPM docker image for Laravel

Docker hub repository is located here: [breakhack/php](https://hub.docker.com/r/breakhack/php)

This image default contain:
- php [official image](https://hub.docker.com/_/php)
- php [composer](https://getcomposer.org/)
- packages:
    - git
    - unzip
- php extensions: 
  - bcmath
  - pdo_mysql
  - pdo_pgsql
  - gd (--with-freetype --with-jpeg --with-webp)
  - zip
  - exif
  - sockets
  - pcntl
  - opcache
