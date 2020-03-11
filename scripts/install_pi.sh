#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt upgrade
apt install -y git zsh vim vim-nox cmake python3-dev golang \
    raspberrypi-kernel-headers libelf-dev libmnl-dev build-essential git \
    wireguard # might need apt to be in testing
