#!/bin/zsh

# Alias substitution for zsh
#
# Author: Jacob Peyron
#

# OS identifier
UNAME="$(uname 2> /dev/null)"


function config_aliases() 
{
    alias -g ...='../..'
    alias -g ....='../../..'
    alias -g .....='../../../..'

    
    LS="ls"
    GREP="grep"
    case $UNAME in
        Darwin)

            # OSX specific config
            # Use GNU coreutils instead of BSD tools
            LS="gls"
            GREP="ggrep"

            ;;
   #     Linux)
   #         ;;
   #     FreeBSD)
   #         ;;
    esac


    alias ls='$LS --color=auto'
    alias lsl='$LS -l --color=auto'
    alias grep='$GREP --color=auto'

    alias ga='git add'
    alias gs='git status'
    alias gd='git diff'
    alias gl='git log --oneline --all --graph --decorate'
    alias gc='git commit --verbose'
}

config_aliases

