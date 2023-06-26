FROM    debian:bullseye

RUN     apt-get update
RUN     apt-get install -y mariadb-server

COPY    ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY    tools/configure.sh /usr/local/bin/configure.sh

RUN     chmod +x /usr/local/bin/configure.sh

ENTRYPOINT ["/usr/local/bin/configure.sh"]
