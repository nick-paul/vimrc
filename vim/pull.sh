#!/usr/bin/env bash

git pull
rm -f ~/.vimrc
cp .vimrc ~/.vimrc

mkdir -p ~/.config/nvim
cp .vimrc ~/.config/nvim/init.vim
