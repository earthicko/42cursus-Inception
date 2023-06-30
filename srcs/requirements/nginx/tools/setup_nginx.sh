#!/bin/bash

openssl req -x509 -newkey rsa:2048 -nodes -keyout $KEY_PATH -out $CERTIFICATE_PATH -days 365 -subj "/C=KR/L=Seoul/O=Seoul/OU=Rush03/CN=donghyle.42.fr"

echo "server 
		{
			listen [::]:443 ssl;
			listen 443 ssl;

			root /var/www/html;
			index index.php;
			server_name	$SERVER_NAME;

			ssl_certificate $CERTIFICATE_PATH;
			ssl_certificate_key $KEY_PATH;
			ssl_protocols TLSv1.2 TLSv1.3;

			location ~ [^/]\.php(/|$) { 
				try_files \$uri =404;
				fastcgi_pass wordpress:9000;
				include fastcgi_params;
				fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
			}
		}" > /etc/nginx/sites-available/wordpress

exec "$@"
