#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Console history

export HISTFILE="$XDG_DATA_HOME/zsh/zhistory"
export HISTSIZE=1000000         # maximum history size in terminal's memory
export SAVEHIST=1000000         # maximum size of history file
