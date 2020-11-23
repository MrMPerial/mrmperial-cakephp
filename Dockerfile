FROM php:7.4.11-apache

RUN requirements="g++ libicu-dev" \
    && apt-get update && apt-get install -y $requirements \
    && docker-php-ext-install mysqli pdo pdo_mysql pcntl intl \
    && requirementsToRemove="g++ libicu-dev" \
    && apt-get purge --auto-remove -y $requirementsToRemove    

RUN curl -sSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get update

RUN a2enmod rewrite

RUN usermod -u 1000 www-data