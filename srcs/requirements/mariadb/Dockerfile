FROM		debian:bullseye

RUN			apt-get update -y && \
			apt-get upgrade -y && \
			apt-get -y install mariadb-server mariadb-client vim

COPY		./tools/mariadb_setup.sh /tmp/mariadb_setup.sh
COPY		./conf/50-server.conf /etc/mysql/mariadb.conf.d/

ENTRYPOINT	["sh", "/tmp/mariadb_setup.sh"]

EXPOSE		3306
