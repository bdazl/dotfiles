#!/bin/zsh

# Setup completion for ZSH
#
# Author: Jacob Peyron
#

config_completion() {
# The following lines were added by compinstall

    zstyle ':completion:*' auto-description 'specify: %d'
    zstyle ':completion:*' completer _complete _ignored _correct _approximate
    zstyle ':completion:*' format 'Completing %d'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' insert-unambiguous true
    zstyle ':completion:*' list-colors ''
    zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
    zstyle ':completion:*' max-errors 2
    zstyle ':completion:*' menu select=2
    zstyle ':completion:*' prompt 'Corrections (errs: %e):'
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    zstyle :compinstall filename '/home/jacob/.zshrc'
    
    autoload -Uz compinit
    compinit
# End of lines added by compinstall
#
    setopt extendedglob
}

apply_if_exist() {
    cmd=$1
    complete=$2
    [[ $commands[$cmd] ]] && eval $("${complete[@]}")
}

config_completion

[[ $commands[gh] ]] && eval $(gh completion -s zsh)
