#!/bin/bash


# install essentials
sudo dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    zsh \
    tmux \
	rxvt-unicode \
	vim \
    git \
	python \
    golang

sudo dnf update

echo Dont forget to generate SSH key


# User should have access to:
#   - terminal -> zsh 

echo Please change default shell. Why does not chsh exist on fedora30?
#if [ -n "$(which lshch)" ]; then
#sudo lchsh << EOF
#$(which zsh)
#EOF
#else 
    #echo Could not install zsh as default shell
    #echo Trying chsh
    #chsh -s $(which zsh) $(whoami)
#fi


