# Jacob's Dotfiles
This is a collection of my personal dotfiles. Some of it is copied from others, some of it is my own preferences.


## Work In Progress
I use my configuration on a daily basis and have been doing so consistently for a couple of year.
During this time it has be come clear that there are some improvements I should make.

I have relied on git branches to handle different setups (work computers, macos, or generally different environments).
This approach has turned out to be quite tedious, because I forget where I've made commits and slight differences
make it hard to keep track of things.


## TODO

* Re-design the repository to take in some values that need not be version controlled (such as the global e-mail for this device).
These values should then be template:able and a script should be made to compile values into a "working state"
* Make git-dependencies into squashed merge-commits via `git subtree`, instead of weak references using `git submodule`
* Simplify VIM-configurations:
    - 0-vundl.vim
    - 1-general.vim
    - 2-keymap.vim
* Try out NeoVIM
* this_self -> here (or self)
* Something like `tldr`, if possible re-use `tldr`, such that my use-cases are covered. E.g: `tldr git` -> `git subtree --squash`
