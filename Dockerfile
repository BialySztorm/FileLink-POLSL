FROM php:8.4-apache

RUN apt-get update && apt-get install -y \
  git zip unzip libpng-dev \
  libzip-dev default-mysql-client

RUN docker-php-ext-install pdo pdo_mysql zip gd

RUN a2enmod rewrite

WORKDIR /var/www

COPY . /var/www

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN COMPOSER_ALLOW_SUPERUSER=1 composer install --no-scripts --no-autoloader

EXPOSE 80

#RUN sed -i 's!/var/www/html!/var/www/html/public!g' \
#  /etc/apache2/sites-available/000-default.conf

COPY start.sh /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]