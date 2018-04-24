#!/bin/zsh

# My ZSH prompt
#
# Author: Jacob Peyron
#

function config_prompt()
{
    autoload -Uz promptinit
    autoload -Uz colors
    promptinit

    # Left prompt
    PS1='%B%(?..%F{red}[%F{white}%?%F{red}] )' # status code: %?
    PS1+='%(!.%F{red}.%F{fg_default_code})' # Color selector for if super user
    PS1+='%b%n'                             # username
    PS1+='%F{magenta}@'                     # @
    PS1+='%F{cyan}%m%u'                     # hostname
    PS1+='%F{red}# %F{fg_default_code}'     # #
    export PS1

    # Right prompt
    export RPS1='%F{green}%~%f' 
}

config_prompt
