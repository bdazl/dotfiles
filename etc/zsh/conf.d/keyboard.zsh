#!/bin/zsh

# Keyboard / ZLE configuration for ZSH
#
# Author: Jacob Peyron
#


function config_keybindings_emacs()
{
    bindkey -e
}

function config_keybindings_vim()
{
    bindkey -v
}

config_keybindings_emacs
#config_keybindings_vim
