#!/bin/zsh
# Copyright (c) 2018-2025 Jacob Peyron <jacob.peyron@gmail.com>
# Use of this source code is governed by an ICU License that can be found in the LICENSE file

export XDG_RUNTIME_DIR=$(getconf DARWIN_USER_TEMP_DIR)

if [ -f /opt/homebrew/bin/brew ]; then
    export BREW_BIN=/opt/homebrew/bin/brew
elif [ -f /usr/local/bin/brew ]; then
    export BREW_BIN=/usr/local/bin/brew
else
    echo "Warning: brew not installed"
fi

if [[ -x "$BREW_BIN" ]]; then
    export BREW_PREFIX="$($BREW_BIN --prefix)"
    eval "$($BREW_BIN shellenv)"
fi
