#!/bin/zsh
# Copyright (c) 2018-2025 Jacob Peyron <jacob.peyron@gmail.com>
# Use of this source code is governed by an ICU License that can be found in the LICENSE file

# Central exports
export LANG=en_US.UTF-8
export EDITOR=vim
export PAGER=less
export SUDO_EDITOR=vim
export HISTSIZE=10000000  # maximum history size in terminal's memory
export SAVEHIST=10000000  # maximum size of history file

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
export CHEAT_USE_FZF=true
export GITHUB_USER=bdazl
export RANGER_LOAD_DEFAULT_RC=FALSE
export GTK_THEME=Adapta

_find_exclude() {
    local exclude_dirs=(
        ".git"
        "__pycache__"
        "node_modules"
    )

    exclude_pattern=""
    for dir in "${exclude_dirs[@]}"; do
        exclude_pattern+=" -name \"$dir\" -o"
    done

    # Remove the trailing '-o'
    exclude_pattern="${exclude_pattern%-o}"
    echo $exclude_pattern
}

export FZF_CTRL_T_COMMAND="find . -mindepth 1 \
  -type d \( $(_find_exclude) \) -prune \
  -o -type d -print \
  -o -type f -print \
  -o -type l -print \
  2> /dev/null | cut -b3-"
# export FZF_CTRL_T_OPTS="
#   --height 50%
#   --preview '~/.dotfiles/bin/preview.sh {}'
#   --preview-window=right
#   --preview-label=' Preview '
#   --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_PREVIEW_COMMAND="~/.dotfiles/bin/preview.sh {}"

# MacOS
if [ "$(uname)" = "Darwin" ]; then
    export MAC_OS="yes"
    export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox
fi
