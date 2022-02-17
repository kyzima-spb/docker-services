#!/usr/bin/env bash                                                                                                
set -e

ROOT_DIR="$(dirname "$(readlink -f "$0")")"


make_secret()
{
    if [[ ! -f $1 ]]; then
        pwgen -s 32 1 > "$1"
    fi
}


if [[ ! -d $ROOT_DIR/secrets ]]; then
    echo "Creating folder for secrets..."
    mkdir "$ROOT_DIR/secrets"
fi


make_secret "$ROOT_DIR/secrets/source_password"
make_secret "$ROOT_DIR/secrets/relay_password"
make_secret "$ROOT_DIR/secrets/admin_password"

docker-compose up
