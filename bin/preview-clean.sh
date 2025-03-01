#!/bin/bash

if command -v kitty > /dev/null 2>&1; then
    kitty +kitten icat --clear --stdin no --transfer-mode memory < /dev/null > /dev/tty
fi
