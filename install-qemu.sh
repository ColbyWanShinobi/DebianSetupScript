#!/usr/bin/env bash

set -e -x

sudo apt update
sudo apt install -y qemu-kvm qemu-utils libvirt-daemon-system libvirt-clients bridge-utils virt-manager ovmf virtiofsd

sudo systemctl enable --now libvirtd

sudo virsh net-start default || true
sudo virsh net-autostart default || true

sudo usermod -aG kvm,input,libvirt ${USER}
newgrp kvm || true
newgrp input || true
newgrp libvirt || true
