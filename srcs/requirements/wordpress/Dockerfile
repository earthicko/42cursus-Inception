FROM		debian:bullseye

RUN			apt-get update && \
			apt-get upgrade -y && \
			apt-get -y install curl php-cli php-mysql mariadb-client php-fpm

RUN			mkdir /run/php

COPY		tools/setup_wordpress.sh /tmp

RUN			chmod +x /tmp/setup_wordpress.sh

ENTRYPOINT	["/tmp/setup_wordpress.sh"]

CMD			["php-fpm7.4", "-F"]
