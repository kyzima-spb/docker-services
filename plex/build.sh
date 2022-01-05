#!/usr/bin/env bash
set -e


build_image() {
    local repo_dir="$(pwd)/plex-repo"

    mkdir -p "$repo_dir"

    pushd $repo_dir
        if [[ ! -d .git ]]; then
            git clone "https://github.com/plexinc/pms-docker.git" .
        else
            git pull --allow-unrelated-histories origin master
        fi

        local dockerfile=""

        case "$(uname -m)" in
            armv7l) dockerfile="Dockerfile.armv7" ;;
            arm64) dockerfile="Dockerfile.arm64" ;;
            x86_64) dockerfile="Dockerfile";;
            *)
                echo "Unsupported platform" >&2
                exit 1
        esac

        docker build -t plexinc/pms-docker:latest -f $dockerfile .
    popd
}


build_image

