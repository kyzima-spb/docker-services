#!/usr/bin/env sh
set -e

source /opt/secrets.sh

checkRequired() {
    if [[ -z $1 ]]; then
        echo "Configuration option $1 empty." >&2
        exit 1
    fi
}

replaceOption() {
    local name=$1
    local value=$2
    sed -i "s~<$name>[^<]*<\/$name>~<$name>$value<\/$name>~" /etc/icecast.xml
}


fileEnv "ICECAST_SOURCE_PASSWORD"
checkRequired "$ICECAST_SOURCE_PASSWORD"
replaceOption "source-password" "$ICECAST_SOURCE_PASSWORD"

fileEnv "ICECAST_RELAY_PASSWORD"
checkRequired "$ICECAST_RELAY_PASSWORD"
replaceOption "relay-password" "$ICECAST_RELAY_PASSWORD"

fileEnv "ICECAST_ADMIN_PASSWORD"
checkRequired "$ICECAST_ADMIN_PASSWORD"
replaceOption "admin-password" "$ICECAST_ADMIN_PASSWORD"

chown -R icecast:icecast /var/log/icecast

exec "$@"