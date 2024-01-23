#!/bin/zsh

# Setup completion for ZSH
#
# Author: Jacob Peyron
#

[[ $commands[zoxide] ]] && eval "$(zoxide init --cmd j zsh)"
[[ $commands[gh] ]] && eval "$(gh completion -s zsh)"
