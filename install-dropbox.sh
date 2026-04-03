#!/usr/bin/env bash

set -e -x

sudo apt update
sudo apt install -y gpg python3-gpg

#Install Dropbox
if [ ! -x "$(command -v dropbox)" ];then
  wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2025.05.20_amd64.deb -O ${HOME}/Downloads/dropbox.deb
  #yes | sudo gdebi ${HOME}/Downloads/dropbox.deb
  sudo apt install ${HOME}/Downloads/dropbox.deb
  sudo apt-key export 5044912E | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/dropbox.gpg
fi
