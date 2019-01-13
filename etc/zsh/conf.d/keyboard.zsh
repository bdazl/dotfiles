#!/bin/zsh

# Keyboard / ZLE configuration for ZSH
#
# Author: Jacob Peyron
#

function config_keybindings_emacs()
{
    bindkey -e
}

function config_keybindings_vim()
{
    bindkey -v

    bindkey -M vicmd "ö" beginning-of-line
    bindkey -M vicmd "ä" end-of-line
    
    # Remove ESC-key lag
    export KEYTIMEOUT=1
}

function bindkeys_special()
{
    # Code taken from:
    # http://www.zshwiki.org/home/zle/bindkeys
    #
    # create a zkbd compatible hash;
    # to add other keys to this hash, see: man 5 terminfo
    typeset -g -A key

    key[Home]="$terminfo[khome]"
    key[End]="$terminfo[kend]"
    key[Insert]="$terminfo[kich1]"
    key[Backspace]="$terminfo[kbs]"
    key[Delete]="$terminfo[kdch1]"
    key[Up]="$terminfo[kcuu1]"
    key[Down]="$terminfo[kcud1]"
    key[Left]="$terminfo[kcub1]"
    key[Right]="$terminfo[kcuf1]"
    key[PageUp]="$terminfo[kpp]"
    key[PageDown]="$terminfo[knp]"

    # Setup keys accordingly
    #
    # I don't really like the insert key, so I skip that one here
    #[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
    [[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
    [[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
    [[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
    [[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
    [[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
    [[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
    [[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
    [[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

    # Finally, make sure the terminal is in application mode, when zle is
    # active. Only then are the values from $terminfo valid.
    if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
        zle-line-init()
        {
            typeset -g __prompt_status="$?"
            echoti smkx
        }
        zle-line-finish()
        {
            echoti rmkx
        }
        zle -N zle-line-init
        zle -N zle-line-finish
        
    else
        zle-line-init()
        {
            typeset -g __prompt_status="$?"
        }
        zle -N zle-line-init
    fi
}

#config_keybindings_emacs
config_keybindings_vim

bindkeys_special
