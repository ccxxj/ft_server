FROM debian:buster

COPY srcs/. /root/

WORKDIR /root/

ARG Autoindex=on

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install wget\
	nginx\
	mariadb-server\
	php7.3-fpm php-mysql\
	php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

RUN mkdir /var/www/localhost &&\
	chown -R $USER:$USER /var/www/* &&\
	chmod -R 755 /var/www/*

COPY /srcs/nginx_autoindex_$Autoindex.conf /etc/nginx/sites-available/localhost

RUN	ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/ &&\
	rm /etc/nginx/sites-enabled/default &&\
	cp /var/www/html/index.nginx-debian.html /var/www/localhost/ &&\
	cp info.php /var/www/localhost/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz &&\
	tar -xf phpMyAdmin-5.0.4-english.tar.gz && rm -rf phpMyAdmin-5.0.4-english.tar.gz &&\
	mv phpMyAdmin-5.0.4-english /var/www/localhost/phpmyadmin &&\
	mv /root/config.inc.php /var/www/localhost/phpmyadmin/

RUN apt-get -y install libnss3-tools &&\
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 &&\
	chmod 777 ./mkcert-v1.4.3-linux-amd64 &&\
	./mkcert-v1.4.3-linux-amd64 localhost &&\
	mv ./localhost.pem /etc/nginx &&\
	mv ./localhost-key.pem /etc/nginx

RUN wget https://wordpress.org/latest.tar.gz &&\
	tar xzvf latest.tar.gz &&\
	mv wordpress/ /var/www/localhost/ &&\
	rm latest.tar.gz &&\
	cp /root/wp-config.php /var/www/localhost/wordpress/

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
	chmod 777 wp-cli.phar &&\
	mv wp-cli.phar /usr/local/bin/wp

RUN	wp cli update

EXPOSE 80 443

ENTRYPOINT ["sh", "/root/init.sh"]