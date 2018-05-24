# Configuration for ZSH

## Overview

The zshrc is run for each new shell and the zshenv is
sourced for every login shell. I currently use emacs
bindings, but it might change. The overall design is:
* Have small special purpose scripts in the directory *`~/.config/zsh`*.
* Use the freedesktop specifications where possible.
* Use VIM keybindings
* Clear prompts

## TODO

* [x] Move current functionality to separate units
* [x] Add special keys like HOME, END, ARROWS (long overdue)
* Source the zshenv into Dotbot and use variables to determine where to put stuff.
* Directory for zshenv. Break coupling
* Rename functions from undercase to minus

# Debug

To debug what's being sourced in the shell, execute
following:

> zsh -x 2>&1 | tee zsh.log
