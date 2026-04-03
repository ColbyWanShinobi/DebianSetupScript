#!/usr/bin/env bash

set -e -x

sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo deluser ${USER} docker || true
sudo groupdel docker || true

sudo rm -rfv /etc/apt/keyrings/docker.gpg /etc/apt/sources.list.d/docker.list | true

sudo apt update
