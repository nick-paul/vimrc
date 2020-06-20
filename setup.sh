#!/bin/bash

set -e

if [ "$(id -u)" == "0" ] && [ -z "$SUDO_USER" ]; then
  echo "Don't run as root."
  exit -1
fi

sudo apt update
sudo apt upgrade

sudo apt install \
  curl \
  vim \
  git \
  build-essential \
  cmake \
  xfce4 \
  htop \
  openssh-server \
  clang \
  python \
  python3 \
  neovim \
  python-neovim \
  python3-neovim \
  fonts-firacode \
  fish \
  tldr

# fzf
if [ ! -d "${HOME}/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

#bash font/install-nerd.sh
#bash pyenv/install.sh
bash vim/setup.sh
