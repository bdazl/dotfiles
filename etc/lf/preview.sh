#!/bin/bash

has-cmd() {
    command -v $1 > /dev/null 2>&1
}

image() {
    file=$1
    w=$2
    h=$3
    x=$4
    y=$5

    if has-cmd kitty; then
        # kitten icat $1
        kitty +kitten icat \
            --silent --stdin no --transfer-mode memory \
            --place "${w}x${h}@${x}x${y}" \
            "$file" < /dev/null > /dev/tty
    elif has-cmd viu; then
        viu "$1"
    fi
}

FILE=${FILE:-$1}
W=$2
H=$3
X=$4
Y=$5

CENTER=${CENTER:-0}
MIME=$(file --dereference --mime -- "$FILE" | awk -F': ' '{print $2}')

B_STYLE=${BAT_STYLE:-numbers}
B_ARGS=("--style=$B_STYLE" "--color=always" "--pager=never" "--highlight-line=$CENTER")

case $MIME in
    application/x-tar* | application/gzip*) tar tf "$FILE" | tree -C --fromfile . | bat "${B_ARGS[@]}" ;;
    inode/directory*) tree -C "$FILE" | bat "${B_ARGS[@]}" ;;
    image/*) image "$FILE" $W $H $X $Y && exit 1 ;;
    *) bat "${B_ARGS[@]}" -- "$FILE" ;;
esac
