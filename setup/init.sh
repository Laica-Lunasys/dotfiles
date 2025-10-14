#!/usr/bin/env bash

cd "$(dirname "$0")"
set -e

_INFO=$(printf "\e[1;32m>>\e[m")
_TASK=$(printf "\e[1;34m::\e[m")
_WARN=$(printf "\e[1;33m!!\e[m")
_ERROR=$(printf "\e[1;31m!!\e[m")

if [ ! -d ~/.fzf ]; then
    echo "$_TASK Setup fzf..."
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-update-rc --no-bash --no-zsh --no-fish
fi

if [ ! -e ${HOME}/.local/bin/sheldon ]; then
    echo "$_TASK Setup sheldon..."
    mkdir -p ${HOME}/.local/bin
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
        | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "$_TASK Setup tpm..."
    mkdir -p ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ${HOME}/.starship ]; then
    echo "$_TASK Setup starship..."
    mkdir -p ${HOME}/.starship/bin
    curl -sS https://starship.rs/install.sh | sh -s -- -y --bin-dir ${HOME}/.starship/bin
fi

echo "$_TASK Setup vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "$_TASK Executing: 'vim -c :PlugInstall'"
vim -c ':PlugInstall' -c ':q' -c ':q'

echo "$_TASK Initialize neovim"
nvim -R --cmd 'set nomore' -c ':Lazy update' -c ':q'

echo "$_TASK Initialize zsh"
zsh --login -c 'source $HOME/.zshrc'

echo "$_INFO Operation success! you can now dive in to the world."
