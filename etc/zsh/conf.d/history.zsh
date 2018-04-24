#!/bin/zsh

# ZSH history
#
# Author: Jacob Peyron
#

function config_history()
{
    setopt inc_append_history   # immediately append history to history file
    setopt hist_ignore_dups     # ignore duplicate commands
    setopt hist_ignore_space    # ignore commands with leading space
}

config_history

