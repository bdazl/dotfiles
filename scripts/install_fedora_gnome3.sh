#!/bin/bash

# Gui related programs end up here
sudo dnf install \
    xsel

# set caps -> esc
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"
echo caps mapped to esc

echo Please set keyboard shortcuts from
echo Super+enter (Open terminal with tmux urxvt)
echo Super+j (Workspace down)
echo Super+k (Workspace up)
echo 
