#!/bin/zsh

# Alias substitution for zsh
#
# Author: Jacob Peyron
#

function config_aliases() 
{
    if [ "$(uname)" = "Darwin" ]; then
        alias ls='ls -G'
        alias ll='ls -G -l'
        alias la='ls -G -la'
        alias grep='grep --color=auto'
        alias lsblk='sudo diskutil list'
    else
        alias ls='ls --color=auto --group-directories-first'
        alias la='ls -lha --time-style=long-iso'
        alias ll='ls -lh --time-style=+%Y-%m-%d'
        alias lll='ls -lhaZ --time-style=long-iso'
        alias grep='grep --color=auto'
        alias tl='tree -C | bat'
    fi

    alias agh='ag --hidden'

    alias ga='git add'
    alias gb='git branch'
    alias gc='git commit --verbose'
    alias gs='git status'
    alias gd='git diff'
    alias gpp='git pull --prune'

    # ShortSHA Date Author Decorate/Branch etc
    # Commit message
    alias gl='git log --graph --date=short --pretty=format:"%C(yellow)%h %C(blue)%ad %C(green)%an %C(auto)%d %n %s"'
    alias gla='git log --oneline --all --graph --decorate'
    alias gfc='git-files-changed'

    alias gdiff='diff --color -u'

    alias nvi='nvim -u ~/.vimrc'

    alias ta='tmux attach'
    alias td='tmux detach'

    alias trn='tr -d "\n"'

    alias sss='ss -ltpn'

    alias h='hyprctl'
    alias k='kubectl'

    alias dima='gammastep -O 3000'
    alias dimb='gammastep -O 2500'
    alias dimmörk='gammastep -O 1900'

    alias lb='lsblk -o name,size,fstype,uuid,model,mountpoints'
    alias lba='lsblk -o name,label,size,fstype,uuid,model,mountpoints'

    alias lz='eza -1 --group-directories-first'
    alias lzz='eza -loM --group-directories-first --git --time-style=+%Y-%m-%d'
    alias lza='eza -liaoM --group-directories-first --git --time-style=+%Y-%m-%d'
    alias lzl='eza -liaoMH --group-directories-first --git --time-style=long-iso'

    # Recurse directories for size of folders. This can take a while.
    alias lt='eza -lar --sort=size --total-size --no-time --no-permissions --no-user'
    alias ltt='lt --tree --color=always | bat -p'

    alias ys='yay -Syu --noconfirm'

    alias signin='eval $(op signin)'

    alias today='date +%Y-%m-%d'
    alias vecka='date +%V'
    alias now='date +%H:%M%t%Y-%m-%d%tV.%V'
}

#----  Aliases as functions (because aliases can't have params)

# nargs: runs your specified param for each newline supplied to stdin
# ex: pgrep slack | nargs renice -n 5 -p {}
function nargs() {
    tr '\n' '\0' | xargs -0 -I {} "${@[@]}"
}

function git-files-changed() {
    local dev=${1:-$(git branch --show-current)}
    local main=${2:-$(git branch -l main master --format '%(refname:short)')}

    git diff --name-only $dev $(git merge-base $dev $main)
}

# Init aliases
config_aliases

