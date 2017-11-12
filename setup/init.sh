#!/usr/bin/env bash
# Prefix
PREFIX="\e[1;32m==>\e[00m"
RPREFIX="\e[1;35m==>\e[00m"
EPREFIX="\e[1;31m!!!\e[00m"
#---------------------------------------

echo -e "$PREFIX Setup zsh..."
# zplug: [ ! -d ~/.zplug ] && mkdir -p ~/.zplug && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
[ ! -d ~/.antigen ] && mkdir -p ~/.antigen && curl -L git.io/antigen > ~/.antigen/antigen.zsh

echo -e "$PREFIX Setup tpm..."
[ ! -d ~/.tmux/plugins/tpm ] && mkdir -p ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo -e "$PREFIX Setup vim Vundle..."
[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle && git clone git://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim

echo -e "$RPREFIX Executing: 'vim -c :PluginInstall'"
vim -c ':PluginInstall' -c ':q' -c ':q'
echo -e "$PREFIX vim / Vundle Ready."
