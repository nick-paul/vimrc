#!/bin/bash

# Setup Vim and NeoVim

# Standard Vim
if [ ! -e "${HOME}/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mkdir -p ~/.vim/swap
    mkdir ~/.vim/backup
    mkdir ~/.vim/undo
fi

# Neovim

if [ ! -e "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    mkdir -p ~/.config/nvim
fi


PYENV="${HOME}/.pyenv"

if [ -d "${PYENV}" ]; then

    # Temp add pyenv to path
    PATH="${HOME}/.pyenv/bin:${PATH}"

    if [ ! -d "${PYENV}/versions/2.7.15" ]; then
        pyenv install 2.7.15
    fi


    if [ ! -d "${PYENV}/versions/3.6.6" ]; then
        pyenv install 3.6.6
    fi


    if [ ! -d "${PYENV}/versions/neovim2" ]; then
        pyenv virtualenv 2.7.15 neovim2
    fi


    if [ ! -d "${PYENV}/versions/neovim3" ]; then
        pyenv virtualenv 3.6.6 neovim3
    fi

    export PATH="/home/nick/.pyenv/bin:$PATH"
    eval "$(pyenv init - --no-rehash)"
    eval "$(pyenv virtualenv-init -)"

    pyenv activate neovim2
    pip install neovim
    pyenv which python

    pyenv activate neovim3
    pip3 install neovim
    pyenv which python

else
    echo "Please install pyenv"
fi

# install plugins
#nvim --headless +PlugInstall +UpdateRemotePlugins +q



