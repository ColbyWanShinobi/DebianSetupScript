#!/usr/bin/env bash

set -e -x

sudo apt update
sudo apt install -y gpg python3-gpg

mkdir -p "${HOME}/Downloads"
DROPBOX_DEB="${HOME}/Downloads/dropbox.deb"
DROPBOX_URL="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2025.05.20_amd64.deb"

#Install Dropbox
if [ ! -x "$(command -v dropbox)" ];then
  wget "${DROPBOX_URL}" -O "${DROPBOX_DEB}"
  #yes | sudo gdebi ${HOME}/Downloads/dropbox.deb
  sudo apt install -y "${DROPBOX_DEB}"
fi

if [ ! -f "/usr/share/keyrings/dropbox.gpg" ] || [ ! -f "/etc/apt/sources.list.d/dropbox.list" ]; then
  if [ ! -f "${DROPBOX_DEB}" ]; then
    wget "${DROPBOX_URL}" -O "${DROPBOX_DEB}"
  fi

  tmpdir="$(mktemp -d)"
  trap 'rm -rf "${tmpdir}"' EXIT

  dpkg-deb -e "${DROPBOX_DEB}" "${tmpdir}/DEBIAN"
  awk '
    /-----BEGIN PGP PUBLIC KEY BLOCK-----/ { in_key=1 }
    in_key { print }
    /-----END PGP PUBLIC KEY BLOCK-----/ { exit }
  ' "${tmpdir}/DEBIAN/postinst" > "${tmpdir}/dropbox.asc"

  sudo install -d -m 0755 /usr/share/keyrings
  sudo gpg --dearmor -o /usr/share/keyrings/dropbox.gpg "${tmpdir}/dropbox.asc"

  arch="$(dpkg --print-architecture)"
  echo "deb [arch=${arch} signed-by=/usr/share/keyrings/dropbox.gpg] http://linux.dropbox.com/debian sid main" | \
    sudo tee /etc/apt/sources.list.d/dropbox.list > /dev/null
fi
