#!/usr/bin/env bash

set -e
#set -x

CODENAME=$(grep CODENAME /etc/os-release | cut -d'=' -f2)

sudo rm -rfv /etc/apt/keyrings/docker.gpg /etc/apt/sources.list.d/docker.list | true

sudo apt update
sudo apt install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings

if [ ! -f "/etc/apt/keyrings/docker.gpg" ]; then
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
 echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(cat /etc/os-release | grep CODENAME | head -n 1 | cut -f2 -d=)" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

sudo apt-get update
sudo apt-get install -y docker-compose-plugin
sudo usermod -aG docker ${USER}
newgrp docker
