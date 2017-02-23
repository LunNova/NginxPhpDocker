#!/bin/bash

cd /root/

mkdir -p /config/php /config/nginx /config/sites /config/tmp

if [ ! -d "/log/" ]; then
	mkdir -p /config/log/
	ln -s /config/log/ /log/
fi

mkdir -p /log/php-fpm /log/nginx

if [ ! -f "/config/php/php-fpm.conf" ]; then
	cp php-fpm.conf /config/php/php-fpm.conf
fi

if [ ! -f "/config/nginx/nginx.conf" ]; then
	cp nginx.conf /config/nginx/nginx.conf
fi

if [ "x$FIXPERMISSIONS"="xtrue" ]; then
	chown -R nginx:www-data /config
	chmod -R 0777 /config
fi

php-fpm7
nginx
