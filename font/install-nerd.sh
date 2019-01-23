#!/bin/sh
set -e

CURDIR=".."

mkdir -p "${CURDIR}/.cache/"

if [ ! -f "${CURDIR}/.cache/UbuntuMono.zip" ]; then
    curl -s -L  https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | \
    egrep -o '/ryanoasis/nerd-fonts/releases/download/v[0-9.]*/UbuntuMono\.zip' | \
    wget --base=http://github.com/ -i - -O "${CURDIR}/.cache/UbuntuMono.zip"
fi

mkdir -p "${HOME}/.local/share/fonts/"
unzip -o -d "${HOME}/.local/share/fonts/" "${CURDIR}/.cache/UbuntuMono.zip"
mkdir -p "${HOME}/.config/fontconfig/conf.d/"
cp "font/nerd.conf" "${HOME}/.config/fontconfig/conf.d/10-ubuntu-mono-nerd-font.conf"

# Build font cache
fc-cache -f
