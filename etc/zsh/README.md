# Configuration for ZSH

## Overview

The zshrc is run for each new shell and the zshenv is
sourced for every login shell. I currently use emacs
bindings, but it might change. The overall goal is to:
* Have small special purpose scripts in the directory *`~/.config/zsh`*.
* Use the freedesktop specifications where possible.

## TODO

* ~~Move current functionality to separate units~~
* Add special keys like HOME, END, ARROWS (long overdue)
* Source the zshenv into Dotbot and use variables to determine where to put stuff.

# Debug

To debug what's being sourced in the shell, execute
following:

> zsh -x 2>&1 | tee zsh.log
