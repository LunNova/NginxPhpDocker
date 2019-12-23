FROM alpine:edge
MAINTAINER Luna Allan <docker@nallar.me>

ENV LANG=C.UTF-8 \
FIXPERMISSIONS=true \
CONFIGPATH=/config

COPY root/ /
RUN chmod +x /root/*.sh && /bin/sh /root/install.sh

VOLUME /config /log

ENTRYPOINT ["/sbin/tini", "-g", "-v", "--", "/root/init.sh"]
