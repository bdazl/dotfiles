#!/bin/zsh

# Initial setup for zsh
#
# Author: Jacob Peyron
#

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

setopt extendedglob

# History
setopt inc_append_history   # immediately append history to history file
setopt hist_ignore_dups     # ignore duplicate commands
setopt hist_ignore_space    # ignore commands with leading space

# Don't make noise
unsetopt beep
