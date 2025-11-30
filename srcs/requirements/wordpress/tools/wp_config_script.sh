#!/bin/sh

sleep 10

if [ ! -f "/var/www/html/wp-config.php" ]; then
	wp core download

	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb

	wp core install --url=$DOMAIN --title=$WEBSITE_NAME --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

	wp user create $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --display_name=kaveO_cheat_engineer --send-email

	chown -R nobody:nobody /var/www/html
	chmod -R 755 /var/www/html

	echo "Wordpress has been successfully installed!"
fi

exec /usr/sbin/php-fpm82 -F
