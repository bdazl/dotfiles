#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Setup path for different system.


function echo-path-base() 
{
    # Setup path
    # set array-output to path typeset
    
    # Simply echo:ing this array will yield a path
    # $HOME/bin like:this:where:this:is:$PATH
    pth=("$HOME/.local/bin" "$HOME/bin" ${PATH})

    # Join spaces with :
    echo "${(j.:.)pth}"
}

function echo-path-osx()
{
    # I crave GNU over BSD stuff
    gnucore="/usr/local/opt/coreutils/libexec/gnubin"
    gnugrep="/usr/local/opt/grep/bin"
    gnufind="/usr/local/opt/findutils/bin"
    
    pth=($gnucore $gnugrep $gnufind)
    echo "${(j.:.)pth}"
}
    
function echo-my-path()
{
    pth="$(echo-path-base)"

    u_name="$(/usr/bin/uname)"
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
