# Jacob's dotfiles
This is a collection of my personal dotfiles. I have machines running various flavors of Linux, MacOS and Win/WSL
and I try to make all settings agnostic to the underlying OS. All configuration files are exist under [etc/](env).

## Install
***Warning: DO NOT INSTALL THESE ON YOUR SYSTEM.*** You should never install a strangers dotfiles. But please, if you
find anything useful: feel free to steal it and let it wither with your health (as the swedish proverb goes:
"slit den med hälsan")

If you disregard the above warning and want to install this anyway:
1. First time run `./bootstrap && ./generate`
2. Run `./install` to link all the static and generated content into your home folder
   (This will not modify or erase any pre-existing files that might clash and you'll get warnings on collisions)

The self-contained tool [Dotbot](https://github.com/anishathalye/dotbot) is used, linked as a submodule to this repo,
to install my configurations as symlinks. This makes it easy to update any new configurations or install them to a
new home folder.

## Design
I'm currently in the process of developing the template/generative approach in this repository. In the past I used
git branches to separate configuration profiles (like what I use for work and privately on different computers).
This approach was way too annoying to work with, with cherry-picks and merges cluttering everything. The main problem
is usually I want to have e-mail setup differently on different computers, but also some machines are naturally more
bare than others.

The approach I use now is a simple `envsubst`, or environment substition. The file `gen/active.env` holds
bash-variables and these are substituted into all generated files (defined in [generate](generate)). This file is
*not* version controlled.

## Scripts
* [bootstrap](bootstrap): ensures the `gen/active.env` file has [default values](gen/default.env).
* [generate](generate): populate the `gen/out/` directory, based on `gen/active.env` values substituting `etc/` files
* [install](install): ensure git submodules are initialized and link all configuration files to `$HOME`
* [update](update): update git submodules to latest commits

## Filesystem
* [bin](bin): scripts and binaries used in repo (or commonly by me)
* [etc](etc): configuration files
* [ext](ext): external files and folders (submodules like `Dotbot`, for instance)
* [gen](gen): generated files (gen/out) and substition variables (gen/active.env)
* [sys](sys): files to be installed on the system (not home folder)
