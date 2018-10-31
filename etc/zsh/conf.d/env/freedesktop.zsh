#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Ensure freedesktop basic variables

[[ "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME="$HOME/.config"
[[ "$XDG_DATA_HOME" ]] || export XDG_DATA_HOME="$HOME/.local/share"
[[ "$XDG_CACHE_HOME" ]] || export XDG_CACHE_HOME="$HOME/.cache"

