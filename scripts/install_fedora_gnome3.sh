#!/bin/bash

# Gui related programs end up here
sudo dnf install \
    xsel \
    gnome-tweaks

# set caps -> esc
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"

# set keyboard shortcuts
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-up "['<Super>k']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-down "['<Super>j']"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows "['<Alt>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows-backward "['<Shift><Alt>Tab']"

# No alert sound
dconf write /org/gnome/desktop/sound/event-sounds "false"

echo caps mapped to esc

echo Please set keyboard shortcuts from
echo Super+enter - Open terminal with tmux urxvt -
echo 
