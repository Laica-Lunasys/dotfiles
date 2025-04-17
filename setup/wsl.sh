#!/usr/bin/env bash
set -e

paths=$(/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c 'echo $env:PATH' | sed -e 's/\;/\n/g')

mkdir -p $HOME/wsl/bin

IFS=$'\n'
for p in $paths; do
    linux_path=$(wslpath $p)

    if [ -e $linux_path ]; then
        for f in $(find $linux_path -mindepth 1 -maxdepth 1 -type f -name '*.exe'); do
            echo $f
            ln -sf $f $HOME/wsl/bin/$(basename $f)
        done
    fi
done
