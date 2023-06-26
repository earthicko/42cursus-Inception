FROM    debian:bullseye

RUN     apk update && apk upgrade && apk add --no-cache \
        mariadb \
        mariadb-client

COPY tools/configure.sh /usr/local/bin/configure.sh

RUN     chmod +x /usr/local/bin/configure.sh

ENTRYPOINT ["/usr/local/bin/configure.sh"]
