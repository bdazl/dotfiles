# Configuration for ZSH

Automation agent guidance lives in [AGENTS.md](../../AGENTS.md). Claude Code instructions are in [CLAUDE.md](../../CLAUDE.md).

## Overview

The zshrc is run for each new shell and the zshenv is
sourced for every login shell. The overall design is:
* Have small special purpose scripts in the directory *`~/.config/zsh`*.
* Use the freedesktop specifications where possible.
* Use vim keybindings
* Clear prompts

# Debug

To debug what's being sourced in the shell, execute
following:

> zsh -x 2>&1 | tee zsh.log
