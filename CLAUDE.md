# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository using [Dotbot](https://github.com/anishathalye/dotbot) for cross-platform configuration management (Linux, macOS, Windows/WSL).

## Commands

- `./install` - Main installation: initializes submodules, runs bootstrap/generate, symlinks configs to `$HOME`
- `./bootstrap` - Creates `gen/active.env` from `gen/default.env` if it doesn't exist
- `./generate` - Performs envsubst on templated files (e.g., gitconfig with EMAIL variable)
- `./update` - Updates git submodules and fetches latest FZF shell bindings

## Architecture

### Directory Structure
- **etc/** - Static configuration files, organized by application (vim, zsh, hypr, etc.)
- **gen/** - Template system: `default.env` defines variables, `active.env` stores local values, `out/` contains generated files
- **ext/** - Git submodules (Dotbot, urxvt plugins)
- **bin/** - Scripts including platform-specific installers in `bin/install/`
- **sys/** - System-level files (for /etc, not home)

### Symlink Configuration
`etc/install.yml` defines all symlink mappings. Dotbot uses this to link configs from this repo into `$HOME`. Static files come from `etc/`, generated files from `gen/out/`.

### Generation System
The `generate` script uses `envsubst` to substitute variables from `gen/active.env` into template files. Currently used for gitconfig (EMAIL variable). Add new generated files by extending the `targets` associative array in `generate`.

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

## Code Style

### Shell (zsh/bash)
- Aliases grouped by tool/purpose in `etc/zsh/conf.d/alias.zsh`
- Git aliases as shell aliases (not git config aliases) for consistency
- Use functions when parameters are needed
