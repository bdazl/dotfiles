#!/bin/zsh

# Alias substitution for zsh
#
# Author: Jacob Peyron
#

function config_aliases() 
{
    alias -g ...='../..'
    alias -g ....='../../..'
    alias -g .....='../../../..'

    alias ls='ls --color=auto'
    alias lsl='ls -l --color=auto'
    alias grep='grep --color=auto'

    alias ga='git add'
    alias gs='git status'
    alias gd='git diff'
    alias gl='git log --oneline --all --graph --decorate'
    alias gc='git commit --verbose'

    alias docker-killall='docker kill $(docker ps -q)'
    # Delete all stopped containers.
    alias docker-rmall='docker rm $(docker ps -a -q)'
    # Delete all untagged images.
    alias docker-rmiall='docker rmi $(docker images -q -f dangling=true)'
}

config_aliases

