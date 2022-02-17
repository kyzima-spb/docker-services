#!/usr/bin/env sh
set -e

source /opt/secrets.sh


makeConfig() {
    local tmplPath="/ezstream/ezstream.tmpl"
    local configPath="/ezstream/ezstream.xml"
    local regexpEmptyComment="s|<([^>]+?)></\1>|<\!-- \0 -->|"  
    envsubst < "$tmplPath" | sed -r "$regexpEmptyComment" > "$configPath"
}

makePlaylist() {
    local playlist=$(find "/data" -name '*.mp3')
    local playlistPath="/ezstream/playlist.txt"
    
    if [[ ! -z "$playlist" ]]; then
        echo "$playlist" > "$playlistPath"
        export EZ_INTAKE_FILENAME="$playlistPath"
    fi
}


# Initialize values that might be stored in a file
fileEnv "EZ_SERVER_PASSWORD"

if [[ -z $EZ_SERVER_HOSTNAME ]]; then
    export EZ_SERVER_HOSTNAME="127.0.0.1"
fi

makePlaylist
makeConfig
clearEnvironment "EZ"

exec "$@"