#!/usr/bin/env bash

set -e -x

sudo apt update
sudo apt install -y flatpak
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
#flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
