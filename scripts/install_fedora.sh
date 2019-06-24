#!/bin/bash


# install essentials
sudo dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    util-linux-user \
    zsh \
    tmux \
	rxvt-unicode \
	vim \
    git \
	python \
    python3-devel \
    golang \
    make \
    gcc-c++ \
    cmake \
    ranger

sudo dnf update

echo Dont forget to generate SSH key


# User should have access to:
#   - terminal -> zsh 

echo Changing shell:
sudo chsh -s $(which zsh) $(whoami)


