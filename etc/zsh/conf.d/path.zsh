#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Setup path for different system.



retval=()
function ret-path-osx()
{
    # I crave GNU over BSD stuff
    gnucore="/usr/local/opt/coreutils/libexec/gnubin"
    gnugrep="/usr/local/opt/grep/bin"
    gnufind="/usr/local/opt/findutils/bin"
    
    retval=($gnucore $gnugrep $gnufind)
}
    
function export-my-path()
{
    typeset -aU path
    path+=("$HOME/.local/bin" "$HOME/bin")

    case $(uname 2> /dev/null) in
        Darwin)

            ret-path-osx 
            path+=$retval
            ;;
    esac
}

# export-my-path
