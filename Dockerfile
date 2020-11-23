FROM php:7.4.11-apache

# install apt dependencies
# some of these are not needed in all php projects
# NOTE: you should prob use specific versions of some of these so you don't break your app
RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
    apt-transport-https \
    ca-certificates \
    openssh-client \
    curl \ 
    dos2unix \
    git \
    gnupg2 \
    dirmngr \
    g++ \	
    jq \
    libedit-dev \
    libfcgi0ldbl \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpq-dev \
# libssl-dev \
# openssh-client \
    supervisor \
    unzip \
    zip \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install \
    pdo_mysql \
    mysqli \
    json \
    readline \
    gd \
    intl

RUN extension=pdo.so

RUN curl -sSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get update

RUN a2enmod rewrite

RUN usermod -u 1000 www-data