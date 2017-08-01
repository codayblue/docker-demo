FROM ubuntu:16.04

RUN apt-get -y update && apt-get install -y software-properties-common python-software-properties 
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update -y && apt-get install -y php7.1 php7.1-dom php7.1-sqlite3 php-apcu php7.1-intl apache2 libapache2-mod-php7.1
ADD app /var/www/app
ADD localhost.conf /etc/apache2/sites-available/localhost.conf
ADD php.ini /etc/php/7.1/apache2/php.ini
RUN chown -R www-data:www-data /var/www/app
RUN a2ensite localhost.conf

VOLUME /var/www/app/database

EXPOSE 80

WORKDIR /var/www/app

CMD /usr/sbin/apache2ctl -D FOREGROUND

