FROM alpine:3.13
LABEL maintainer="Kirill Vercetti <office@kyzima-spb.com>"

ENTRYPOINT ["/docker-entrypoint.sh"]

RUN set -x \
    && apk update \
    && apk add --no-cache sed gettext ezstream \
    && rm -rf /var/cache/apk/* \
    && wget --no-check-certificate -qO /opt/secrets.sh "https://kyzima-spb.github.io/src/docker/secrets.sh"

VOLUME ["/data"]

ADD ./root /

CMD ["/usr/bin/ezstream", "-c", "/ezstream/ezstream.xml"]
