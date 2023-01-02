#!/bin/zsh

separator="#JSEP"

function echo_resolv()
{
    echo $separator
    echo search got.jeppesensystems.com jeppesensystems.com osp.jeppesensystems.com support.jeppesensystems.com testnet.jeppesensystems.com ymq.jeppesensystems.com jeppesen.com corp.gds.jeppesen.com
    echo nameserver 10.67.6.4
    echo nameserver 10.67.6.21 
}

found_sep=$(grep "$separator" /etc/resolv.conf)
if [ -z "$found_sep" ]; then
    echo_resolv | sudo tee --append /etc/resolv.conf > /dev/null
fi

cd
if [ "$TMUX" = "" ]; then tmux; fi
