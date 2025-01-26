# Jacob's dotfiles
This is a collection of my personal dotfiles. I have machines running various flavors of Linux, MacOS and Win/WSL
and I try to make all settings agnostic to the underlying OS. All configuration files are exist under [etc/](env).

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
* [bootstrap](bootstrap): ensures the `gen/active.env` file has [default values](gen/default.env).
* [generate](generate): populate the `gen/out/` directory, based on `gen/active.env` values substituting `etc/` files
* [update](update): update git submodules to latest commits

## Filesystem
* [bin](bin): scripts and binaries used in repo (or commonly by me)
* [etc](etc): configuration files
* [ext](ext): external files and folders (submodules like `Dotbot`, for instance)
* [gen](gen): generated files (gen/out) and substition variables (gen/active.env)
* [sys](sys): files to be installed on the system (not home folder)

## License
[ICU License](LICENSE)
