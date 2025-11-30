FROM	alpine:3.22

RUN		apk update && apk add icu pcre openssl imagemagick php82 php82-fpm php82-mysqli php82-curl php82-dom php82-exif php82-fileinfo php82-pecl-imagick php82-pecl-igbinary \
		php82-intl php82-mbstring php82-openssl php82-xml php82-zip php82-pecl-apcu php82-pecl-memcached libmemcached php82-opcache php82-pecl-redis php82-phar

RUN		echo "memory_limit = 512M" > /etc/php82/conf.d/memory-limit.ini

RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN		ln -sf /usr/bin/php82 /usr/bin/php && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN		wp cli update

COPY	./conf/www.conf /etc/php82/php-fpm.d/

WORKDIR	/var/www/html

COPY	./tools/wp_config_script.sh /tmp

RUN		chmod +x /tmp/wp_config_script.sh

ENTRYPOINT [ "/tmp/wp_config_script.sh" ]
