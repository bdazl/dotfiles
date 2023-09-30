#!/bin/bash -e
#

FILE=${FILE:-$1}
CENTER=${CENTER:-0}
MIME=$(file --dereference --mime -- "$FILE" | awk '{print $2}')

B_STYLE=${BAT_STYLE:-numbers}
B_ARGS=("--style=$B_STYLE" "--color=always" "--pager=never" "--highlight-line=$CENTER")

case $MIME in
    application/x-tar* | application/gzip*) tar tf "$FILE" | tree -C --fromfile . | bat "${B_ARGS[@]}" ;;
    inode/directory*) tree -C "$FILE" | bat "${B_ARGS[@]}" ;;
    *) bat "${B_ARGS[@]}" -- "$FILE" ;;
esac
