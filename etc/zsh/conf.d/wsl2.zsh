#!/bin/zsh

separator="#JSEP"

function echo_resolv()
{
    echo $separator
    echo search got.jeppesensystems.com jeppesensystems.com osp.jeppesensystems.com support.jeppesensystems.com testnet.jeppesensystems.com ymq.jeppesensystems.com jeppesen.com corp.gds.jeppesen.com
    echo nameserver 10.67.6.4
    echo nameserver 10.67.6.21 
}

function install_jep_resolv()
{
    found_sep=$(grep "$separator" /etc/resolv.conf)
    if [ -z "$found_sep" ]; then
        echo "I need sudo access to patch WSL2 with the correct /etc/resolv.conf:"
        echo_resolv | sudo tee --append /etc/resolv.conf > /dev/null
    fi
}

function start_tmux()
{
    #command -v tmux >/dev/null 2>&1 || exit 0
    #if [ "$TMUX" = "" ] && tmux
    [[ $commands[tmux] ]] && [ "$TMUX" = "" ] && tmux
}

function is_wsl2()
{
    iswsl="$(uname -a | grep WSL2 )"
    [ -n "$iswsl" ]
}

if [ is_wsl2 ]; then
    install_jep_resolv
    start_tmux
fi
