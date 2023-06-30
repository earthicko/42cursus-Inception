#!/bin/bash

service mariadb start

MYSQL_SETUP_DONE_INDICATOR=/var/lib/mysql/.setupdone

if [ ! -f "$MYSQL_SETUP_DONE_INDICATOR" ]; then

	sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf

	echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" > maria.sql
	echo "CREATE USER IF NOT EXISTS '${DB_USER_NAME}'@'%' IDENTIFIED BY '${DB_USER_PASS}';" >> maria.sql
	echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_NAME}'@'%';" >> maria.sql
	echo "FLUSH PRIVILEGES;" >> maria.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';" >> maria.sql

	mariadb < maria.sql

	mysqladmin shutdown -p${DB_ROOT_PASS}

	touch $MYSQL_SETUP_DONE_INDICATOR
fi

exec "$@"
