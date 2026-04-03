#!/usr/bin/env bash

set -e -x

#Install AWSCLI
if [ ! -x "$(command -v aws)" ];then
  wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -O ${HOME}/Downloads/awscliv2.zip
  unzip -d ${HOME}/Downloads/ ${HOME}/Downloads/awscliv2.zip
  sudo ${HOME}/Downloads/aws/install
fi
