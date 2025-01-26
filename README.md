# Jacob's dotfiles
This is a collection of my personal dotfiles. I have machines running various flavors of Linux, MacOS and Win/WSL
and I try to make all settings agnostic to the underlying OS. All configuration files are exist under [etc/](env).

## Install
> [!WARNING]
> Do not install a strangers dotfiles onto your computer.

I want to install this anyway:
1. First time run `./bootstrap && ./generate`
2. Run `./install` to link all the static and generated content into your home folder
   (This will not modify or erase any pre-existing files that might clash and you'll get warnings on collisions)

The self-contained tool [Dotbot](https://github.com/anishathalye/dotbot) is used, linked as a submodule to this repo,
to install my configurations as symlinks. This makes it easy to update any new configurations or install them to a
new home folder.

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
