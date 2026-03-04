# Jacob's dotfiles
This is a collection of my personal dotfiles. I have machines running various flavors of Linux, MacOS and Win/WSL
and I try to make all settings agnostic to the underlying OS. Configuration files live under [etc/](etc).

Automation agent guidance lives in [AGENTS.md](AGENTS.md). Claude Code instructions are in [CLAUDE.md](CLAUDE.md).

## Prerequisites

> [!NOTE]
> The self-contained tool [Dotbot](https://github.com/anishathalye/dotbot) is used, linked as a submodule to this repo.

### Linux and in general:
* Shell of choice
* [Python](https://www.python.org/)

### Windows
* [PowerShell](https://learn.microsoft.com/en-us/powershell/)

### Mac
* [Homebrew](https://brew.sh/)

## Installation
> [!WARNING]
> Do not install a strangers dotfiles onto your computer.

Main installation:
* `[./install](install)` to symlink all the static and generated content into your home folder

## Scripts
* [install](install): ensure git submodules are initialized and link all configuration files to `$HOME`
* [bootstrap](bootstrap): creates `~/.config/git/local` from template if missing
* [update](update): update git submodules to latest commits

## Symlinks
Dotbot uses `etc/install.yml` to define which files are symlinked into `$HOME`.
All symlinked files come from `etc/`. Platform-specific manifests are applied via `etc/install.mac.extra.yml` (Darwin) and `etc/install.win.yml` (Windows/WSL). Machine-local overrides live in `local/` (not tracked).

## Filesystem
* [bin](bin): scripts and binaries used in repo (or commonly by me)
* [cfg](cfg): supporting configuration assets referenced by scripts/configs
* [etc](etc): configuration files
* [ext](ext): external files and folders (submodules like `Dotbot`, for instance)
* [lib](lib): helper libraries used by scripts
* [llm](llm): prompt templates and shared string mappings for LLM tooling
* [sys](sys): files to be installed on the system (not home folder)
* [win](win): Windows/WSL specific assets and config

## License
[ICU License](LICENSE)
