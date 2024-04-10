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
        alias la='ls -G -la'
        alias grep='grep --color=auto'
        alias lsblk='sudo diskutil list'
    else
        alias ls='ls --color=auto --group-directories-first'
        alias la='ls -lha --time-style=long-iso'
        alias ll='ls -lh --time-style=+%Y-%m-%d'
        alias lll='ls -lhaZ --time-style=long-iso'
        alias grep='grep --color=auto'
        alias tl='tree -C | bat'
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

    alias h='hyprctl'
    alias k='kubectl'

    alias dima='gammastep -O 3000'
    alias dimb='gammastep -O 2500'
    alias dimmörk='gammastep -O 1900'

    alias lz='eza -loM --group-directories-first --git --time-style=+%Y-%m-%d'
    alias lzz='eza -loaM --group-directories-first --git --time-style=long-iso'

    # Recurse directories for size of folders. This can take a while.
    alias lzzz='eza -loaZM --group-directories-first --no-time --total-size'
}

config_aliases

