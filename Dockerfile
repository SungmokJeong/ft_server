# BASE IMAGE
FROM debian:buster

# APT-GET UPDATE
RUN apt-get update
RUN apt-get -y upgrade

# INSTALL WGET
RUN apt-get -y install wget

# INSTALL NGINX
RUN apt-get -y install nginx

# SETUP SSL
RUN apt-get -y install openssl
RUN openssl req -newkey rsa:4096 -days 60 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Gon/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
RUN	mv localhost.dev.crt etc/ssl/certs/
RUN	mv localhost.dev.key etc/ssl/private/
RUN chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key
COPY ./srcs/default etc/nginx/sites-available/default

# INSTALL PHP
RUN apt-get -y install php-fpm 

# INSTALL MARIADB(MYSQL)
RUN apt-get -y install mariadb-server php-mysql

# INSTALL WORDPRESS
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz
RUN mv wordpress/ var/www/html/
RUN chown -R www-data:www-data /var/www/html/wordpress
COPY ./srcs/wp-config.php var/www/html/wordpress/wp-config.php

# SETUP PHPMYADMIN
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN	tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages phpmyadmin
RUN mv phpmyadmin /var/www/html/
COPY ./srcs/config.inc.php var/www/html/phpmyadmin/config.inc.php

COPY ./srcs/run.sh ./
CMD bash run.sh
