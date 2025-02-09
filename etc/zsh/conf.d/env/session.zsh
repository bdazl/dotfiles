#!/bin/zsh
# Copyright (c) 2018-2025 Jacob Peyron <jacob.peyron@gmail.com>
# Use of this source code is governed by an ICU License that can be found in the LICENSE file

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    REMOTE_SESSION=true
else
    case $(ps -o comm= -p "$PPID") in
        sshd|*/sshd) REMOTE_SESSION=true;;
        *) REMOTE_SESSION=false;;
    esac
fi

# Session information
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export WAYLAND=true
fi
