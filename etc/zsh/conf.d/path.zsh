#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Setup path for different system.

function echo-if-dir-exists()
{
    if [[ -d "${1}" ]] then
        echo ${1}
    fi
}

function remove-non-existing()
{
    local out=""
    for arg do
        e="$(echo-if-dir-exists $arg)"

        # if length of string is non-zero
        if [[ -n "$e" ]] then
            out+="$e "
        fi
    done
    echo $out
}

function echo-path-base() 
{
    # Setup path
    # set array-output to path typeset

    # Simply echo:ing this array will yield a path
    # $HOME/bin like:this:where:this:is:$PATH
    pth=( \
        $(remove-non-existing \
            "$HOME/.local/bin" \
            "$HOME/bin" \
            "$HOME/go/bin" \
        ) \
        ${PATH} \
    )

    # Join spaces with :
    echo "${(j.:.)pth}"
}

function echo-path-osx()
{
    # I crave GNU over BSD stuff
    gnucore="/usr/local/opt/coreutils/libexec/gnubin"
    gnugrep="/usr/local/opt/grep/bin"
    gnufind="/usr/local/opt/findutils/bin"
    
    pth=$(remove-non-existing $gnucore $gnugrep $gnufind)
    echo "${(j.:.)pth}"
}
    
function echo-my-path()
{
    pth="$(echo-path-base)"

    u_name="$(uname)"
    case $u_name in Darwin):
        pth=("$(echo-path-osx)" $pth)
        ;;
    esac

    echo "${(j.:.)pth}"
}

function export-my-path()
{
    export PATH="$(echo-my-path)"
}

# export-my-path
