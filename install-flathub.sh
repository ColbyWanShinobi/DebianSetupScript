#!/usr/bin/env bash

set -e -x

#sudo add-apt-repository -y ppa:flatpak/stable
#sudo apt update
sudo apt install -y flatpak gnome-software-plugin-flatpak
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
#flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

# Boxes Problem on Ubuntu, can't find KVM: 
#LIBVIRT_DEFAULT_URI="qemu:///session" flatpak run org.gnome.Boxes

#NEWFILE=/etc/apparmor.d/bwrap
#echo "Creating ${NEWFILE}"
#sudo touch ${NEWFILE}
#sudo chown ${USER}:${USER} ${NEWFILE}
#cat > ${NEWFILE} <<DELIM
#abi <abi/4.0>,
#include <tunables/global>

#profile bwrap /usr/bin/bwrap flags=(unconfined) {
#  userns,

  # Site-specific additions and overrides. See local/README for details.
#  include if exists <local/bwrap>
#}
#DELIM
#sudo chown root:root ${NEWFILE}
#sudo systemctl reload apparmor

