#!/usr/bin/env bash

cd "$(dirname "$0")"
set -e

_INFO=$(printf "\e[1;32m>>\e[m")
_TASK=$(printf "\e[1;34m::\e[m")
_WARN=$(printf "\e[1;33m!!\e[m")
_ERROR=$(printf "\e[1;31m!!\e[m")

echo "$_TASK Setup fzf..."
if [ ! -d ~/.fzf ]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash --no-fish
fi

echo "$_TASK Setup zinit..."
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d $(dirname $ZINIT_HOME) ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    zsh -c "source ~/.zshrc && exit 0"
fi

echo "$_TASK Setup tpm..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    mkdir -p ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "$_TASK Setup vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "$_TASK Setup packer.nvim..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "$_TASK Executing: 'vim -c :PlugInstall'"
vim -c ':PlugInstall' -c ':q' -c ':q'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim -c ':q'
echo "$_TASK Installed vim packages"

echo "$_INFO Operation success! you can now dive in to the world."
