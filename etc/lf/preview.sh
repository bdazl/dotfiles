#!/bin/bash
set -e

file=${FILE:-$1}

# Actual preview
~/.etc/bin/preview $@

# Add the special exit code requirements for images
mime=$(file --dereference --mime -- "$file" | awk -F': ' '{print $2}')
case $mime in
    image/*) exit 1 ;;
    video/*) exit 1 ;;
    *) exit 0 ;;
esac
