#!/bin/zsh

# bindkey / zle configuration for zsh
#
# Author: Jacob Peyron
#

# This variable is the first thing defined in .zshrc and since this file
# is sourced; we do not need to re-define it. It is left here as a reference
# to not get confused where it is used.
#
# readonly ZSH_DIR=$XDG_CONFIG_HOME/zsh

# Main options
bindkey -v  # VIM-mode

bindkey -M vicmd "ö" beginning-of-line
bindkey -M vicmd "ä" end-of-line

# Load fzf plugins
if command -v fzf &> /dev/null; then
    . "$ZSH_DIR/fzf/completion.zsh"
    . "$ZSH_DIR/fzf/key-bindings.zsh"
else
    bindkey "^R" history-incremental-search-backward
fi

# The rest of the code in this file is inspired from:
# http://www.zshwiki.org/home/zle/bindkeys

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

# I don't use the insert key, so I skip that one here
#[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

if [ "$(uname)" = "Darwin" ]; then
    # I had problems with append at the end messing up
    # ability to remove stuff
    bindkey '^?' backward-delete-char
fi

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
