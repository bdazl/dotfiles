#!/bin/bash

redraw() {
    # The redraw triggers another clean operation
    # Add file stuff here to handle re-entrance
    rfile=/tmp/lf-redraw
    if [ ! -f $rfile ]; then
        touch $rfile
        lf -remote "send redraw"
    else
        rm -f $rfile
    fi
}

if command -v kitty > /dev/null 2>&1; then
    kitty +kitten icat --clear --stdin no --transfer-mode memory < /dev/null > /dev/tty
    redraw
fi
