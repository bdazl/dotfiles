# AGENTS.md

Guidance for automation agents working in this repository.
See [CLAUDE.md](CLAUDE.md) for Claude Code instructions and keep overlapping guidance in sync.

## Language
- Conversation: Swedish preferred
- Code, comments, commit messages, documentation: Formal English

## Repository Overview
- Personal dotfiles repo using Dotbot for cross‑platform config management (Linux, macOS, Windows/WSL).

## Commands
- `./install` - Main install: init submodules, run bootstrap/generate, symlink configs to `$HOME`
- `./bootstrap` - Create `gen/active.env` from `gen/default.env` if missing
- `./generate` - `envsubst` templates (e.g., gitconfig with EMAIL variable)
- `./update` - Update submodules and fetch latest FZF shell bindings

## Architecture
- `etc/` - Static configs by app (vim, zsh, hypr, etc.)
- `gen/` - Template system: `default.env`, `active.env`, `out/` for generated files
- `ext/` - Git submodules (Dotbot, plugins)
- `bin/` - Scripts, platform installers in `bin/install/`
- `sys/` - System files intended for `/etc`

## Symlink Configuration
- `etc/install.yml` defines symlink mappings.
- Static files from `etc/`; generated files from `gen/out/`.

## Platform Handling
- Linux: `install.yml`
- macOS: `install.mac.extra.yml` (auto‑loaded on Darwin)
- Windows: `install.win.yml`

## Package Management
- Arch Linux: use `yay` (AUR helper), not `pacman` directly.

## Git Conventions
- Default branch: `main`
- Commit style: lowercase, no trailing period
- Format: `component: brief description`
- Atomic commits (one logical change per commit)
- Never amend unless explicitly requested

## Shell Style (zsh/bash)
- Aliases grouped by tool/purpose in `etc/zsh/conf.d/alias.zsh`
- Prefer shell aliases over git config aliases
- Use functions when parameters are needed
