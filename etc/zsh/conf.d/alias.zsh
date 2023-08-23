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

    # This ensures that whatever comes after sudo also is expanded prior to exection
    # So my user aliases works as sudo. Very neat :D
    alias sudo='sudo '

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

    alias k='kubectl'
    alias kns='k config view -o jsonpath="{.contexts[?(@.name == \"$(k config current-context)\")].context.namespace}"'

    alias podrm='podman container rm --all --force'
    alias podprune='podman system prune'
    alias podclean='podprune || podrm'
}

config_aliases

