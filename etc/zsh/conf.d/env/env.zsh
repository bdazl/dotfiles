#!/bin/zsh
#
# Author: Jacob Peyron <jacob@peyron.io>
#

# Central exports
export LANG=en_US.UTF-8
export EDITOR=vim
export PAGER=less
export SUDO_EDITOR=vim
export HISTSIZE=1000000         # maximum history size in terminal's memory
export SAVEHIST=1000000         # maximum size of history file

# freedesktop.org
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Keyboard environment (layout, repeat rate, etc...)
export XKB_DEFAULT_LAYOUT=se
export XKB_DEFAULT_MODEL=pc105
export XKB_DEFAULT_OPTIONS=caps:escape
#export XKB_DEFAULT_VARIANT=,nodeadkeys
export KEYTIMEOUT=1  # Remove ESC-key lag in ZSH

# Wayland keyboard variables
export WLC_REPEAT_RATE=45
export WLC_REPEAT_DELAY=250

#export BROWSER=qutebrowser
export BROWSER=firefox

# Paths
export HISTFILE="$XDG_DATA_HOME/zsh/zhistory"
export DOWNLOADS="$HOME/Downloads"
export DOTFILES="$HOME/.dotfiles"

# Program defaults
export GITHUB_USER=bdazl
export RANGER_LOAD_DEFAULT_RC=FALSE
export FZF_DEFAULT_COMMAND="find ."
# export FZF_PREVIEW_COMMAND="~/.dotfiles/scripts/preview.sh {}"
export CHEAT_USE_FZF=true

export GTK_THEME=Adapta

# MacOS
if [ "$(uname)" = "Darwin" ]; then
    export MAC_OS="yes"
    export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox
fi
