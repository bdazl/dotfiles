#!/bin/zsh

# Setup completion for ZSH
#
# Author: Jacob Peyron
#

command -v zoxide &> /dev/null && eval "$(zoxide init --cmd j zsh)"
command -v gh &> /dev/null && eval "$(gh completion -s zsh)"
