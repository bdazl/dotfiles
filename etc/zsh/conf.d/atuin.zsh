#!/bin/zsh

# Use Atuin for persistent history search when it is installed. Keep the
# standard Zsh/FZF bindings as a fallback and preserve the regular Up key.
if (( ${+commands[atuin]} )); then
    eval "$(atuin init zsh --disable-up-arrow)"
fi
