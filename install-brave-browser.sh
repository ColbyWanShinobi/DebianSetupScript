#!/usr/bin/env bash

set -e -x

#Install Brave Browser
if [ ! -f "/usr/share/keyrings/brave-browser-archive-keyring.gpg" ]; then
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
fi
if [ ! -f "/etc/apt/sources.list.d/brave-browser-release.list" ]; then
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
fi
if [ ! -x "$(command -v brave-browser)" ];then
  sudo apt update
  sudo apt install -y brave-browser
fi