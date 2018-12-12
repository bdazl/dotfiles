#!/bin/zsh

# My ZSH prompt
#
# Author: Jacob Peyron
#

function echo-left-prompt()
{
    l='%B%(?..%F{red}[%F{white}%?%F{red}] )' # status code: %?
    l+='%(!.%F{red}.%F{fg})' # Color selector for if super user
    l+='%b%n'                # username
    l+='%F{magenta}@'        # @
    l+='%F{cyan}%m%u'        # hostname
    l+='%F{red}# %F{fg}'     # #

    echo "$l"
}

function echo-right-prompt()
{
    r=""

    # If in vi-command mode
    if [[ $KEYMAP = vicmd ]] then
       r+="%F{white}[%F{red}CMD%F{white}]"
    fi
    r+="%F{green}%~%f"

    echo "$r"
}

function config_prompt()
{
    autoload -Uz promptinit
    autoload -Uz colors
    promptinit

    export PROMPT="$(echo-left-prompt)"
    export RPROMPT="$(echo-right-prompt)"

    # Pressing ESC in VI-mode triggers this
    zle-keymap-select() {
        PROMPT="$(echo-left-prompt)"
        RPROMPT="$(echo-right-prompt)"

        () { return $__prompt_status }
        zle reset-prompt
    }
    zle -N zle-keymap-select
}

config_prompt
