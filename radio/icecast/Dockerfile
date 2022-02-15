FROM alpine:3.13
LABEL maintainer="Kirill Vercetti <office@kyzima-spb.com>"

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8000
VOLUME ["/var/log/icecast"]

RUN set -x \
    && apk update \
    && apk add --no-cache sed gettext icecast mailcap \
    && rm -rf /var/cache/apk/* \
    && wget --no-check-certificate -qO /opt/secrets.sh "https://kyzima-spb.github.io/src/docker/secrets.sh"

# RUN set -x \
#     && chown -R icecast:icecast /var/log/icecast

ADD ./root /

CMD ["icecast", "-c", "/etc/icecast.xml"]