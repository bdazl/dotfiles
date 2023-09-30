#!/bin/bash


# install essentials
sudo dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    util-linux-user \
    zsh \
    tmux \
	vim \
    git \
    cscope \
    python \
    python3-devel \
    python3-flake8 \
    pipenv \
    golang \
    make \
    gcc-c++ \
    cmake \
    podman \
    podman-compose \
    ranger \
    java \
    e2fsprogs \
    tree \
    fd-find \
    bat \
    zoxide

# Must be done after rpmfusion is installed
sudo dnf install ffmpeg

sudo dnf update

echo Downloading Go utilities
go get github.com/svent/sift

echo Dont forget to generate SSH key


# User should have access to:
#   - terminal -> zsh

echo Changing shell:
sudo chsh -s $(which zsh) $(whoami)
