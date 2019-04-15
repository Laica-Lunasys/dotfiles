#!/usr/bin/env bash
# Prefix
_info_prefix=$(printf "\e[1;34m::\e[m")
_notify_prefix=$(printf "\e[1;32m==>\e[m")
_error_prefix=$(printf "\e[1;31m!!\e[m")
#---------------------------------------

echo "$_info_prefix Setup zsh..."
#[ ! -d ~/.antigen ] && mkdir -p ~/.antigen && curl -L git.io/antigen > ~/.antigen/antigen.zsh
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug

echo "$_info_prefix Setup fzf..."
[ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --no-bash --no-zsh --no-fish

echo "$_info_prefix Setup tpm..."
[ ! -d ~/.tmux/plugins/tpm ] && mkdir -p ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "$_info_prefix Setup vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "$_notify_prefix Executing: 'vim -c :PlugInstall'"
vim -c ':PlugInstall' -c ':q' -c ':q'

#echo "$_info_prefix Setup vim Vundle..."
#[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle && git clone git://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim

#echo "$_notify_prefix Executing: 'vim -c :PluginInstall'"
#vim -c ':PluginInstall' -c ':q' -c ':q'

echo "$_info_prefix vim / Vundle Ready."
