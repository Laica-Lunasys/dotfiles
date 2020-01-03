#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

_INFO=$(printf "\e[1;32m>>\e[m")
_TASK=$(printf "\e[1;34m::\e[m")
_WARN=$(printf "\e[1;33m!!\e[m")
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
    echo "$_TASK Checking requirements..."
    REQUIRED=("curl" "git")
    OPTIONAL=("tmux" "zsh" "vim" "nvim")

    for v in ${REQUIRED[@]}; do
        if [ "$(which "$v" &> /dev/null; echo $?)" == 0 ]; then
            echo "$_INFO Passed: $v"
        else
            echo "$_ERROR Could not find requirements: $v"
            exit 1
        fi
    done
    for v in ${OPTIONAL[@]}; do
        if [ "$(which "$v" &> /dev/null; echo $?)" == 0 ]; then
            echo "$_INFO Passed: $v"
        else
            echo "$_WARN Could not find optional: $v"
        fi
    done

    echo "$_TASK All check passed"
}

# Install - Install dotfiles
_install() {
    echo "$_TASK Extracting..."
    mkdir -p $HOME/.config
    for f in $(_search); do
        ln -snfv $PWD/$f $HOME/$f
    done
    bash $PWD/setup/init.sh
}

# Clean - Remove dotfiles
_clean() {
    set +e
    echo "$_TASK Removing dotfiles..."
    for f in $(_search); do
        rm -rfv $HOME/$f
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
