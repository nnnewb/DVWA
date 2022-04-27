FROM php:7-apache-bullseye
RUN sed -i 's/deb\.debian\.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/security\.debian\.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    apt-get update
ADD https://ghproxy.com/github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd mysqli pdo_mysql && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . /var/www/html
RUN cp /var/www/html/config/config.inc.php.docker /var/www/html/config/config.inc.php

RUN chown www-data:www-data -R /var/www/html && \
    chown www-data:www-data /var/www/html/config && \
    chown www-data:www-data /var/www/html/hackable/uploads && \
    touch /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt && \
    chown www-data:www-data /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt

