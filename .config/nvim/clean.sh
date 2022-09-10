#!/bin/bash
set -e
cd "$(dirname "$0")"

rm -rfv ./plugin/packer_compiled.lua
rm -rfv $HOME/.local/share/nvim/site/pack/packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
