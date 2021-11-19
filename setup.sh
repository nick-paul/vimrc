#!/bin/bash

set -e

if [ "$(id -u)" == "0" ] && [ -z "$SUDO_USER" ]; then
  echo "Don't run as root."
  exit -1
fi

#sudo apt update
#sudo apt upgrade

sudo apt install \
  curl \
  vim \
  neovim \
  git \
  htop \
  python3 \
  fonts-firacode \
  fish \
  silversearcher-ag

# fzf
if [ ! -d "${HOME}/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

# Vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

CURDIR=$(pwd)
mkdir -p ~/.config/nvim
ln -sf $CURDIR/.config/fish/config.fish         ~/.config/fish/config.fish
ln -sf $CURDIR/.config/nvim/init.vim            ~/.config/nvim/init.vim
ln -sf $CURDIR/.config/nvim/init.vim            ~/.vimrc
ln -sf $CURDIR/.config/nvim/coc-settings.json   ~/.config/nvim/coc-settings.json

nvim --headless +PlugInstall +PlugUpdate +qa
