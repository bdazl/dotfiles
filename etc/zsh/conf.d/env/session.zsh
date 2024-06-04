#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#

readonly remote=remote/ssh

export SESSION=na
export SESSION_TYPE=unknown
export SEAT=na
export TTY_=na

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=$remote
else
    case $(ps -o comm= -p "$PPID") in
        sshd|*/sshd) SESSION_TYPE=$remote;;
    esac
fi


if ! command -v loginctl &> /dev/null || [[ "$SESSION_TYPE" == "$remote" ]]; then
    return
fi

# Session information
export SESSION=$(loginctl | grep active |  grep $USER | awk '{print $1}')
export SESSION_TYPE=$(loginctl show-session $SESSION | grep Type | tr '=' ' ' | awk '{print $2}')

if [[ "$SESSION_TYPE" == "wayland" ]]; then
    export WAYLAND="yes"
fi

# export UID=$(loginctl | grep $USER | awk '{print $2}')
# export USER=$(loginctl | grep $USER | awk '{print $3}')
# export USER=$(loginctl | grep $USER | awk '{print $3}')
export SEAT=$(loginctl | grep $USER | awk '{print $4}')
# $TTY == /dev/pts/x (or somthn)
export TTY_=$(loginctl | grep $USER | awk '{print $5}')
