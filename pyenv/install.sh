#!/bin/bash

# ensure root permissions
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo "export PATH=\"~/.pyenv/bin:\$PATH\"" >> ~/.bashrc
echo "eval \"\$(pyenv init - --no-rehash)\"" >> ~/.bashrc
echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bashrc


. ~/.pyenv/bin/pyenv update

