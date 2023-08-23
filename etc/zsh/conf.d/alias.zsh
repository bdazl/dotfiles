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

    alias ga='git add'
    alias gb='git branch'
    alias gc='git commit --verbose'
    alias gs='git status'
    alias gd='git diff'
    alias gpp='git pull --prune'

    # ShortSHA Date Author Decorate/Branch etc
    # Commit message
    alias gl='git log --graph --date=short --pretty=format:"%C(yellow)%h %C(blue)%ad %C(green)%an %C(auto)%d %n %s"'
    alias gla='git log --oneline --all --graph --decorate'

    alias gdiff='diff --color -u'

    alias nvi='nvim -u ~/.vimrc'

    alias ta='tmux attach'
    alias td='tmux detach'
}

config_aliases

