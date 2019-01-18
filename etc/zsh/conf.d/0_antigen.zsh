#!/bin/zsh

# Antigen plugin management
#
# Author: Jacob Peyron
#

ANTIGEN_LOG=/home/jacob/tmp/antigen.log
source $HOME/.dotfiles/etc/zsh/conf.d/antigen/antigen.zsh

# Load oh-my-zsh lib
#antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply


