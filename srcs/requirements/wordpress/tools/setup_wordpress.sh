#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

	chmod +x wp-cli.phar

	mv wp-cli.phar /bin/wp

	wp core download --path=/var/www/html --allow-root

	cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

	cd /var/www/html/

	wp config set DB_NAME $DB_NAME --allow-root
	wp config set DB_USER $DB_USER_NAME --allow-root
	wp config set DB_PASSWORD $DB_USER_PASS --allow-root
	wp config set DB_HOST $WP_DB_HOST --allow-root

	wp core install --url=$WP_DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

	wp user create $WP_USER1_NAME $WP_USER1_EMAIL --role=$WP_USER1_ROLE --user_pass=$WP_USER1_PASS --allow-root

	sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf

	wp plugin update --all --allow-root

fi

exec "$@"
