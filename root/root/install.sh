#!/bin/sh
set -e

cd /root/

apk --no-cache add ca-certificates php7-fpm php7-json nginx tini bash curl openssl sudo
update-ca-certificates

rm /etc/php7/php-fpm.conf
ln -s /config/php/php-fpm.conf /etc/php7/php-fpm.conf

rm /etc/nginx/nginx.conf
ln -s /config/nginx/nginx.conf /etc/nginx/nginx.conf

rm -rf /tmp/nginx
ln -s /config/tmp /tmp/nginx

rm -rf /log

curl -L -o master.zip https://github.com/Neilpang/acme.sh/archive/master.zip
unzip master.zip
rm master.zip
