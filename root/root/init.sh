#!/bin/bash

cd /root/

if [ -d acme.sh-master ]; then
	chmod -R 0777 acme.sh-master
	if [ ! -d /config/acme.sh ]; then
		pushd acme.sh-master
		sudo -u nginx ./acme.sh --install --home /config/acme.sh
		popd
	else
		pushd /config/acme.sh
		. acme.sh.env
		export LE_WORKING_DIR="/config/acme.sh"
		alias acme.sh="/config/acme.sh/acme.sh"
		export PATH=/config/acme.sh:$PATH
		sudo -u nginx ./acme.sh --upgrade  --home /config/acme.sh --auto-upgrade 0
		./acme.sh --install-cronjob --home /config/acme.sh
		sudo -u nginx ./acme.sh --cron --home /config/acme.sh
		popd
	fi
	rm -rf acme.sh-master
fi

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
