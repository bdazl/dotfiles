# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

See [AGENTS.md](AGENTS.md) for automation agent guidance and keep overlapping guidance in sync.

## Repository Overview

This is a personal dotfiles repository using [Dotbot](https://github.com/anishathalye/dotbot) for cross-platform configuration management (Linux, macOS, Windows/WSL).

## Commands

- `./install` - Main installation: initializes submodules, runs bootstrap, symlinks configs to `$HOME`
- `./bootstrap` - Creates `local/gitconfig` from template if missing
- `./update` - Updates git submodules and fetches latest FZF shell bindings

## Architecture

### Directory Structure
- **etc/** - Static configuration files, organized by application (vim, zsh, hypr, etc.)
- **local/** - Machine-local overrides (not tracked): `zsh.zsh` sourced by zshrc, `install.yml` applied by install
- **ext/** - Git submodules (Dotbot, urxvt plugins)
- **bin/** - Scripts including platform-specific installers in `bin/install/`
- **cfg/** - Supporting configuration assets referenced by scripts/configs
- **lib/** - Helper libraries used by scripts
- **win/** - Windows/WSL-specific assets and config
- **sys/** - System-level files (for /etc, not home)

### Symlink Configuration
`etc/install.yml` defines all symlink mappings. Dotbot uses this to link configs from this repo into `$HOME`. All symlinked files come from `etc/`.

### Git Identity
The shared gitconfig includes `~/.etc/local/gitconfig` (i.e. `local/gitconfig` in the repo root).
Bootstrap creates it from `etc/git/gitconfig.local.template` if missing, defaulting to `jacob@peyron.io`.

### Platform Handling
- Linux: Standard `install.yml`
- macOS: Additional `install.mac.extra.yml` loaded automatically on Darwin
- Windows: Separate `install.win.yml` manifest

### Package Management
- Arch Linux: Use `yay` (AUR helper) for installing packages, not `pacman` directly

## Language

- Conversation: Swedish is preferred
- Code, comments, commit messages, documentation: Formal English

## Git Conventions

### Commit Style
- Lowercase, no trailing period
- Format: `component: brief description`
- Examples:
  - `vim: fix fzf preview script path`
  - `zsh: alias gsv (git status --verbose)`
  - `remove unused configs: conan registry, i3status`

### Workflow
- Atomic commits: one logical change per commit
- Never amend unless explicitly requested
 - Default branch: `main`

## Code Style

### Shell (zsh/bash)
- Aliases grouped by tool/purpose in `etc/zsh/conf.d/alias.zsh`
- Git aliases as shell aliases (not git config aliases) for consistency
- Use functions when parameters are needed
