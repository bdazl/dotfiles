#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Default programs and user names. Some misc are in here as well

export LANG=en_US.UTF-8
export EDITOR=vim
export PAGER=less
export SUDO_EDITOR=vim

#export BROWSER=qutebrowser
export BROWSER=firefox
if [ "$(uname)" = "Darwin" ]; then
    export MAC_OS="yes"
    export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox
fi

export GITHUB_USER=bdazl
export RANGER_LOAD_DEFAULT_RC=FALSE
