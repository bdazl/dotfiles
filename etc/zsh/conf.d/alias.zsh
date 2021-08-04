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
        alias lsmnt='sudo diskutil list'
    else
        alias ls='ls --color=auto --group-directories-first'
        alias ll='ls -l'
        alias grep='grep --color=auto'
        alias tl='tree -C | less -R'
        alias lsmnt='sudo fdisk -l'
    fi

    # ask before delete
    alias rm='rm -i'

    alias ga='git add'
    alias gs='git status'
    alias gd='git diff'

    # ShortSHA Date Author Decorate/Branch etc
    # Commit message
    alias gl='git log --graph --date=short --pretty=format:"%C(yellow)%h %C(blue)%ad %C(green)%an %C(auto)%d %n %s"'
    alias gla='git log --oneline --all --graph --decorate'

    alias gc='git commit --verbose'
    alias gb='git branch'

    alias gpp='git pull --prune'

    alias gdiff='diff --color -u'
}

config_aliases

