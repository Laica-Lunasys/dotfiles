#!/usr/bin/env bash

# Prefix
PREFIX="\e[1;32m==>\e[00m"
RPREFIX="\e[1;35m==>\e[00m"
EPREFIX="\e[1;31m!!!\e[00m"
#==========================

echo -e "$PREFIX Setup dotfiles..."
for file in `ls -A ~/dotfiles/dotfiles`; do
    ln -sfv ~/dotfiles/dotfiles/$file ~/$file
done

echo -e "$PREFIX Setup zsh..."
[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

echo -e "$PREFIX Setup vim Vundle..."
[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle && git clone git://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim

echo -e "$RPREFIX Please execute: 'vim -c :PluginInstall'"

while true;do

    echo ":: Excecute this time?"

    read answer

    case $answer in
        y|yes|Y|YES)
            vim -c ':PluginInstall'
            break
            ;;
        n|no|N|NO)
            break
            ;;
        *)
            echo -e "Cannot understand $answer.\n"
            ;;
    esac
done

echo "Done."
