#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#

if ! command -v loginctl &> /dev/null; then
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
