FROM		debian:bullseye

WORKDIR		/db

RUN			apt-get update && \
			apt-get upgrade -y && \
			apt-get install -y mariadb-server

COPY		/tools/setup_mariadb.sh /tmp
RUN			chmod +x /tmp/setup_mariadb.sh

ENTRYPOINT	["/tmp/setup_mariadb.sh"]

CMD			["mysqld_safe", "--safe-mode"]
