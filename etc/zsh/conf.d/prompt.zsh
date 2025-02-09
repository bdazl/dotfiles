#!/bin/zsh
# Copyright (c) 2025 Jacob Peyron <jacob.peyron@gmail.com>
# Use of this source code is governed by an ICU License that can be found in the LICENSE file

# Define right and left prompt

config-prompt() {
    autoload -Uz promptinit
    autoload -Uz colors
    promptinit

    export PROMPT="$(left-prompt)"
    export RPROMPT="$(right-prompt)"

    # Pressing ESC in VI-mode triggers this
    zle-keymap-select() {
        PROMPT="$(left-prompt)"
        RPROMPT="$(right-prompt)"

        () { return $__prompt_status }
        zle reset-prompt
    }
    zle -N zle-keymap-select
}

left-prompt() {
    host_col='%F{cyan}'
    if $REMOTE_SESSION; then
        host_col='%F{red}'
    fi

    l='%B%(?..%F{red}[%F{white}%?%F{red}] )' # status code: %?
    l+='%(!.%F{red}.%F{fg})' # Color selector for if super user
    l+='%b%n'                # username
    l+='%F{magenta}@'        # @
    l+="${host_col}%m%u"     # hostname
    l+='%F{yellow}# %F{fg}'  # #

    echo "$l"
}

right-prompt() {
    r=""

    # If in vi-command mode
    if [[ $KEYMAP = vicmd ]] then
       r+="%F{white}[%F{red}CMD%F{white}]"
    fi
    r+="%F{green}%~%f"

    echo "$r"
}

config-prompt
