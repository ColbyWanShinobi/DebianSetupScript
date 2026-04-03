#!/usr/bin/env bash

set -e -x

#Install VSCode
if [ ! -x "$(command -v code)" ];then
  wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O ${HOME}/Downloads/vscode.deb
  sudo apt install ${HOME}/Downloads/vscode.deb
fi
