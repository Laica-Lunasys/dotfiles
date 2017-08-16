#!/usr/bin/env bash

checkos() {
    case "$OSTYPE" in
        linux*)
            echo "linux"
            ;;
        freebsd*)
            echo "bsd"
            ;;
        darwin*)
            echo "macos"
            ;;
        sunos*)
            echo "solaris"
            ;;
    esac
}

checkdist() {
    if [ -e /etc/os-release ]; then
        DIST=$(cat /etc/os-release | grep "^ID=" | sed -e 's/"//g' | cut -c 4-)
    else
        DIST="unknown"
    fi
    echo $DIST
}

checkos
checkdist