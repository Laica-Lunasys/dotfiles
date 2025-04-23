#!/usr/bin/env bash
set -e

is_wsl=false
if [ -e /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    is_wsl=true
else
    exit 0
fi

bindir="$HOME/.local/share/wsl-support/bin"

if [ "$1" == "install" ]; then
    paths=$(sh -c "cd /mnt/c; /mnt/c/Windows/System32/cmd.exe /c 'echo %PATH%' | sed -e 's/\;/\n/g'")

    if [ -e $bindir ]; then
        rm -rf $bindir
    fi

    mkdir -p $bindir

    IFS=$'\n'
    for p in $paths; do
        if [ $p != "" ]; then
            linux_path=$(wslpath $p)

            if [ -e $linux_path ]; then
                for f in $(find $linux_path -mindepth 1 -maxdepth 1 -type f \( -name '*.exe' -o ! -name '*.*' \)); do
                    ln -sfv $f $bindir/$(basename $f)
                done
            fi
        fi
    done
fi

if [ "$1" == "clean" ]; then
    rm -rf $bindir
fi
