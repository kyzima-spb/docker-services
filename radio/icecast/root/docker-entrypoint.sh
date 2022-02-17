#!/usr/bin/env sh
set -e

source /opt/secrets.sh


makeConfig() {
    local tmplPath="/etc/icecast.tmpl"
    local configPath="/etc/icecast.xml"
    envsubst < "$tmplPath" > "$configPath"
}


# Initialize values that might be stored in a file
fileEnv "ICECAST_ADMIN"
fileEnv "ICECAST_SOURCE_PASSWORD"
fileEnv "ICECAST_RELAY_PASSWORD"
fileEnv "ICECAST_ADMIN_USER" "admin"
fileEnv "ICECAST_ADMIN_PASSWORD"

# Fix permission denited error
chown -R icecast:icecast /var/log/icecast

makeConfig
clearEnvironment "ICECAST"

exec "$@"