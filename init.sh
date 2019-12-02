#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

_INFO=$(printf "\e[1;34m::\e[m")
_TASK=$(printf "\e[1;32m=>\e[m")
_ERROR=$(printf "\e[1;31m!!\e[m")

# Search - Find dotfiles & config
_search() {
    find . -mindepth 1 -maxdepth 1 \
        -name '.*' \
        -and -not -name '.DS_Store' \
        -and -not -name '.git' \
        -and -not -name '.gitmodules' \
        -and -not -name '.gitignore' \
        -and -not -name '.config' \
        | sed -e 's/\.\///g'

    find .config/ -mindepth 1 -maxdepth 1 \
        | sed -e 's/\.\///g'
}

# List - List of dotfiles
_list() {
    for f in $(_search); do
        echo "$PWD/$f ($HOME/$f)"
    done
}

# Check - Check requirements
_check() {
    echo "$_INFO Checking requirements..."
    if [ ! $(which "curl" 2>/dev/null) ]; then
        echo "$_ERROR Could not find: curl"
    fi
    echo "$_INFO All check passed"
}

# Install - Install dotfiles
_install() {
    echo "$_INFO Extracting..."
    mkdir -p $HOME/.config
    for f in $(_search); do
        ln -snfv $PWD/$f $HOME/$f
    done
    bash $PWD/setup/init.sh
}

# Clean - Remove dotfiles
_clean() {
    set +e
    for f in $(_search); do
        echo "$_INFO Removing $HOME/$f"
        rm -rf $HOME/$f
    done

    echo "$_TASK Removing fzf"
    rm -rf $HOME/.fzf

    echo "$_TASK Removing Antigen"
    rm -rf $HOME/.antigen

    echo "$_TASK Removing vim bundles..."
    rm -rf $HOME/.vim/bundle
    rm -rf $HOME/.vim/plugged
}

if [ "$1" = "list" ]; then
    _list
elif [ "$1" = "check" ]; then
    _check
elif [ "$1" = "install" ]; then
    _check
    _install
elif [ "$1" = "clean" ]; then
    _clean
else
    echo "Usage: <list|check|install|clean>"
fi
