#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Golang environment

# Not longer needed, as of GO 1.13
# export GO111MODULE=on
export GO111MODULE=auto

# for image magick
if [ $(uname) = "Darwin" ]; then
    export CGO_CFLAGS_ALLOW="-Xpreprocessor"
fi
