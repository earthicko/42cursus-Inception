#!/bin/bash

MYSQL_SETUP_DONE_INDICATOR=/var/lib/mysql/.setupdone

if [ ! -f "$MYSQL_SETUP_DONE_INDICATOR" ]; then

	service mariadb start

	echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" > maria.sql
	echo "CREATE USER IF NOT EXISTS '${DB_USER_NAME}'@'%' IDENTIFIED BY '${DB_USER_PASS}';" >> maria.sql
	echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_NAME}'@'%';" >> maria.sql
	echo "FLUSH PRIVILEGES;" >> maria.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';" >> maria.sql

	mariadb < maria.sql

	mysqladmin shutdown -p${DB_ROOT_PASS}

	service mariadb stop

	touch $MYSQL_SETUP_DONE_INDICATOR
fi

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
exec "$@"
