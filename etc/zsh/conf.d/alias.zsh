#!/bin/zsh

# Alias substitution for zsh
#
# Author: Jacob Peyron
#

function config_aliases() 
{
    if [ "$(uname)" = "Darwin" ]; then
        alias ls='ls -G'
        alias ll='ls -G -l'
        alias grep='grep --color=auto'
    else
        alias ls='ls --color=auto --group-directories-first'
        alias ll='ls -l'
        alias grep='grep --color=auto'
    fi

    alias ga='git add'
    alias gs='git status'
    alias gd='git diff'

    # ShortSHA Date Author Decorate/Branch etc
    # Commit message
    alias gl='git log --graph --date=short --pretty=format:"%C(yellow)%h %C(blue)%ad %C(green)%an %C(auto)%d %n %s"'
    alias gls='git log --oneline --all --graph --decorate'

    alias gc='git commit --verbose'
    alias gb='git branch'

    alias docker-killall='docker kill $(docker ps -q)'
    # Delete all stopped containers.
    alias docker-rmall='docker rm $(docker ps -a -q)'
    # Delete all untagged images.
    alias docker-rmiall='docker rmi $(docker images -q -f dangling=true)'
}

config_aliases

