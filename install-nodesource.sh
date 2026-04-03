#! /bin/bash

set -e
#set -x

sudo apt remove -y nodejs npm
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt install -y nodejs
node --version
npm --version

npm config set prefix ~/.local
