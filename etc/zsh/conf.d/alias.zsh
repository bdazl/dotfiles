#!/bin/zsh
# Copyright (c) 2018-2025 Jacob Peyron <jacob.peyron@gmail.com>
# Use of this source code is governed by an ICU License that can be found in the LICENSE file
#
# Alias substitution for zsh

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

    alias agh='ag --hidden --ignore .git'

    alias c='clear'

    alias dff='df -h -x tmpfs -x devtmpfs -x efivarfs'

    alias eop='eval $(op signin)'

    alias ga='git add'
    alias gb='git branch'
    alias gcb='git branch --show-current'
    alias gcf='git-files-changed'
    alias gc='git commit --verbose'
    alias gd='git diff'
    alias gs='git status'
    alias gsh='git show'
    alias gpp='git pull --prune'
    alias gl='git log --graph --date=short --pretty=format:"%C(yellow)%h %C(blue)%ad %C(green)%an %C(auto)%d %n %s"'
    alias gla='git log --oneline --all --graph --decorate'

    alias gdiff='diff --color -u'

    alias hexit='hyprctl dispatch exit'

    alias nvi='nvim -u ~/.vimrc'

    alias pst='ps -e -o pid,user,cmd --forest'
    alias psu='ps-user'

    alias rs='rsync --progress'

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

    local list='ls'
    if command -v eza >/dev/null 2>&1; then
        alias lz='eza -1 --group-directories-first'
        alias lza='eza -1a --group-directories-first'
        alias lzz='eza -loM --group-directories-first --git --time-style=+%Y-%m-%d'
        alias lzl='eza -liaoMH --group-directories-first --git --time-style=long-iso'

        # Recurse directories for size of folders. This can take a while.
        alias lt='eza -lar --sort=size --total-size --no-time --no-permissions --no-user'
        alias ltt='lt --tree --color=always | bat -p'
        alias list='eza'

        alias lbin='lz ~/bin'
    else
        alias lbin='la ~/bin'
    fi

    alias ldi='find . -maxdepth 1 -type d | sed "s|^\./||"'
    alias ldir="ldi | nargs $list --color=always -ld --time-style=+%Y-%m-%d {} ;"

    alias ys='yay -Syu --noconfirm'

    alias signin='eval $(op signin)'

    alias today='date +"%Y-%m-%d  (%d %b)"'
    alias now='date -Iseconds'

    alias kl='date +%H:%M'
    alias idag='date +"%d %b %Y"'
    alias nu='kl; today; vecka'
}

#----  Aliases as functions (because aliases can't have params)

# nargs: runs your specified param for each newline supplied to stdin
# ex: pgrep slack | nargs renice -n 5 -p {}
nargs() {
    tr '\n' '\0' | xargs -0 -I {} "${@[@]}"
}

git-files-changed() {
    local dev=${1:-$(git branch --show-current)}
    local main=${2:-$(git branch -l main master --format '%(refname:short)')}

    git diff --name-only $dev $(git merge-base $dev $main)
}

ps-user() {
    ps -u $USER -U $USER -o pid,cmd --forest
}

vecka() {
    week=${1:-$(date +%V)}
    year=${2:-$(date +%Y)}

    jan1=$(date -d "$year-01-01" +%u)

    # Calculate days to add to jan1 to get to the monday
    # We subtract 1 from week number since we want to count from week 1
    days_to_mon=$(( (week - 1) * 7 - (jan1 - 1) ))
    days_to_sun=$(( days_to_mon + 6 ))

    d_mon="$year-01-01 +$days_to_mon days"
    d_sun="$year-01-01 +$days_to_sun days"
    mon=$(date -d $d_mon +%Y-%m-%d)
    sun=$(date -d $d_sun +%Y-%m-%d)
    echo "v.$week: $mon (mån) - $sun (sön)"
}

# Init aliases
config_aliases

