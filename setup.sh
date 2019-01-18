#!/bin/bash

set -e

if [ "$(id -u)" == "0" ] && [ -z "$SUDO_USER" ]; then
  echo "Don't run as root."
  exit -1
fi

# enable all deb-src in sources.list
sudo sed -i '/^#\sdeb-src /s/^#//' "/etc/apt/sources.list"

sudo apt update
sudo apt upgrade -y

if ! command -v nvim; then
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt update
  sudo apt install -y neovim
fi

sudo apt install -y curl

if ! command -v npm; then
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
fi

if ! command -v openvpn; then
  wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg | apt-key add -
  echo "deb http://build.openvpn.net/debian/openvpn/stable xenial main" > /etc/apt/sources.list.d/openvpn-aptrepo.list
  sudo apt update
  sudo apt install -y openvpn
fi

if ! command -v fish; then
  sudo add-apt-repository ppa:fish-shell/release-2
  sudo apt update
  sudo apt install -y fish
fi

sudo apt install -y \
  vim \
  git \
  nodejs \
  build-essential \
  cmake \
  xfce4 \
  htop \
  openssh-server \
  clang \
  python \
  python3 \
  libclang-6.0-dev \
  clang-6.0 \
  libreadline6-dev \
  libsqlite3-dev \
  liblzma-dev \
  libbz2-dev \
  tk8.5-dev \
  blt-dev \
  libgdbm-dev \
  libssl-dev \
  libncurses5-dev \
  pkg-config \
  exuberant-ctags

sudo apt build-dep -y python python3

sudo -u $USER bash << EOF

  set -e

  mkdir -p "${HOME}/.local/src/"
  mkdir -p "${HOME}/.local/bin/"

  if [ ! -e "${HOME}/.local/bin/cquery" ]; then

    if [ ! -d "${HOME}/.local/src/cquery" ]; then
      git clone --recursive https://github.com/cquery-project/cquery.git "${HOME}/.local/src/cquery"
    fi

    rm -rf "${HOME}/.local/src/cquery/build"
    mkdir "${HOME}/.local/src/cquery/build"
    cd "${HOME}/.local/src/cquery/build"

    CC=clang-6.0
    CXX=clang++-6.0
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DSYSTEM_CLANG=ON -DCMAKE_PREFIX_PATH='/usr/lib/llvm-6.0/'
    cmake --build .
    cd ~/.local/bin

    ln -s ../src/cquery/build/cquery .
  fi

  if ! grep -Fq ".local/bin" "${HOME}/.bashrc"; then
    echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> "${HOME}/.bashrc"
  fi

EOF

# Install fzf
if [ ! -d "${HOME}/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

#bash font/install-nerd.sh
#bash pyenv/install.sh
bash vim/setup.sh
