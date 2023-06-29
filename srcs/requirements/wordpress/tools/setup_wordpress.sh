#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

	chmod +x wp-cli.phar

	mv wp-cli.phar /bin/wp

	wp core download --path=/var/www/html --allow-root

	cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

	cd /var/www/html/

	wp config set DB_NAME $M_DB_NAME --allow-root
	wp config set DB_USER $M_USER_NAME --allow-root
	wp config set DB_PASSWORD $M_USER_PASS --allow-root
	wp config set DB_HOST $W_DB_HOST --allow-root

	wp core install --url=$DOMAINE_NAME --title=$W_TITLE --admin_user=$W_ADMIN_U --admin_password=$W_ADMIN_P --admin_email=$W_ADMIN_E --skip-email --allow-root

	wp user create $USER_N $EMAIL --role=$ROLE --user_pass=$USER_P --allow-root

	sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf

	wp plugin update --all --allow-root

fi

exec "$@"
