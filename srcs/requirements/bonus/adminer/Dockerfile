FROM alpine:3.22

WORKDIR /app

RUN apk update && apk add wget php php-mysqli php-json php-session php-openssl php-curl php-phar

RUN mkdir -p /var/www/html/adminer && \
	cd /var/www/html/adminer && \
	wget "https://www.adminer.org/latest.php" -O index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html/adminer"]
