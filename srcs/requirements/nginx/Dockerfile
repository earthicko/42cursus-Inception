FROM		debian:bullseye

EXPOSE		443

RUN			apt-get update && \
			apt-get upgrade -y && \
			apt-get install -y nginx openssl

COPY		tools/nginx.conf /etc/nginx/
COPY		tools/setup_nginx.sh /tmp

RUN			chmod +x /tmp/setup_nginx.sh

ENTRYPOINT	["/tmp/setup_nginx.sh"]

CMD			["nginx" , "-g" , "daemon off;"]
