#!/bin/zsh
# Copyright (c) 2018-2025 Jacob Peyron <jacob.peyron@gmail.com>
# Use of this source code is governed by an ICU License that can be found in the LICENSE file
#
# PATH manipulation

echo-if-dir-exists() {
    if [ -d "${1}" ]; then
        echo ${1}
    fi
}

remove-non-existing() {
    local out=""
    for arg do
        e="$(echo-if-dir-exists $arg)"

        # if length of string is non-zero
        if [ -n "$e" ]; then
            out+="$e "
        fi
    done
    echo $out
}

echo-path-base() {
    # Setup path
    # set array-output to path typeset

    # Simply echo:ing this array will yield a path
    # $HOME/bin like:this:where:this:is:$PATH
    pth=( \
        $(remove-non-existing \
            "$HOME/.local/bin" \
            "$HOME/bin" \
            "$HOME/go/bin" \
            "$HOME/.cargo/bin" \
            "$HOME/.elan/bin" \
        ) \
        ${PATH} \
    )

    # Join spaces with :
    echo "${(j.:.)pth}"
}

echo-path-osx() {
    gnucore="/usr/local/opt/coreutils/libexec/gnubin"
    gnugrep="/usr/local/opt/grep/bin"
    gnufind="/usr/local/opt/findutils/bin"
    
    pth=$(remove-non-existing $gnucore $gnugrep $gnufind)
    echo "${(j.:.)pth}"
}
    
echo-path() {
    pth="$(echo-path-base)"

    u_name="$(uname)"
    case $u_name in Darwin):
        pth=("$(echo-path-osx)" $pth)
        ;;
    esac

    echo "${(j.:.)pth}"
}

echo-pythonpath() {
    pth=( \
        $(remove-non-existing \
            "$HOME/.etc/lib/py" \
        ) \
        ${PYTHONPATH} \
    )
    echo "${(j.:.)pth}"
}

export PATH=$(echo-path)
export PYTHONPATH=$(echo-pythonpath)
