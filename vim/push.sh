#!/usr/bin/env bash

change=$1

if [ $# -eq 0 ]
then
    echo "Please specify a change"
    exit 1
fi

rm .vimrc
cp ~/.config/nvim/init.vim .vimrc

git add --all
git commit -m "$change"
git push -u origin master

