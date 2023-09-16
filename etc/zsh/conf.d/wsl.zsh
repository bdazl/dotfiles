#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Setup wsl2

is_wsl2()
{
    [ -n "$(uname -a | grep WSL2)" ]
}

start_tmux()
{
    [[ $commands[tmux] ]] && [ "$TMUX" = "" ] && tmux
}

if is_wsl2; then
    start_tmux
    set bell-style none
fi
