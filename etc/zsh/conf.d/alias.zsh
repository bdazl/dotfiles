#!/bin/zsh
# Copyright (c) 2018-2025 Jacob Peyron <jacob.peyron@gmail.com>
# Use of this source code is governed by an ICU License that can be found in the LICENSE file
#
# Alias substitution for zsh

function config_aliases() 
{
    alias ls='ls --color=auto --group-directories-first'
    alias la='ls -lha --time-style=long-iso'
    alias ll='ls -lh --time-style=+%Y-%m-%d'
    alias lll='ls -lhaZ --time-style=long-iso'

    alias agh='ag --hidden --ignore .git'

    alias c='clear'

    alias dff='df -h -x tmpfs -x devtmpfs -x efivarfs'

    alias eop='eval $(op signin)'

    alias fdh='fd --no-ignore-vcs -H'

    alias ga='git add'
    alias gb='git branch --show-current'
    alias gbb='git branch'
    alias gba='git branch --all'
    alias gcf='git-files-changed'
    alias gc='git commit --verbose'
    alias gd='git diff'
    alias gs='git status'
    alias gsv='git status --verbose'
    alias gsh='git show'
    alias ggrep='git grep -nI --heading --break'
    alias gpp='git pull --prune'
    alias gl='git log --graph --date=short --pretty=format:"%C(yellow)%h %C(blue)%ad %C(green)%an %C(auto)%d %n %s"'
    alias gla='git log --oneline --all --graph --decorate'
    alias gll='gl --patch'

    alias gdiff='diff --color -u'

    alias grep='grep --color=auto'

    alias hexit='hyprctl dispatch exit'

    alias nvi='nvim -u ~/.vimrc'

    alias pst='ps -e -o pid,user,cmd --forest'
    alias psu='ps-user'

    alias rs='rsync -av --info=progress2'

    alias ta='tmux attach'
    alias td='tmux detach'

    alias trn='tr -d "\n"'

    alias tp='tree-pager'

    alias sss='ss -ltpn'

    alias h='hyprctl'
    alias k='kubectl'

    alias lb='lsblk -o name,size,fstype,uuid,model,mountpoints'
    alias lba='lsblk -o name,label,size,fsavail,fstype,uuid,model,mountpoints'

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

    alias datum='date +%Y%m%d'
    alias datumm='date +%Y-%m-%d'
    alias today='date +"%Y-%m-%d  (%d %b)"'

    alias now='date -Iseconds'
    alias noww='date +%Y-%m-%d_%H%M%S'

    alias kl='date +%H:%M'
    alias nu='kl; today; vecka'

    if [ "$(uname)" = "Darwin" ]; then
        # These are useful when gnu coreutils is not installed
        # alias ls='ls -G'
        # alias ll='ls -G -l'
        # alias la='ls -G -la'
        # alias grep='grep --color=auto'
        alias lsblk='sudo diskutil list'
    fi
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

tree-pager() {
    p="${1:-.}"
    tree -C "$p" | bat -p
}

load-common() {
    . "$ETC/bin/common"
}

halp() {
    cat <<'HALP'
── files ──────────────────────────────────────────────────────
  la        ls -lha                long listing, all files
  ll        ls -lh                 long listing
  lll       ls -lhaZ               long listing with SELinux context
  lz        eza -1                 one-per-line (eza)
  lza       eza -1a                one-per-line, all files
  lzz       eza -loM --git         detailed listing with git status
  lzl       eza -liaoMH --git      full detail with inode/header
  lt        eza --sort=size        recursive, sorted by size
  ltt       lt --tree | bat        recursive tree, sorted by size
  ldi       find dirs              list directories (names only)
  ldir      find dirs + ls -ld     list directories with details
  lbin      ls ~/bin               list personal scripts
  tp        tree | bat             tree with pager

── disk ───────────────────────────────────────────────────────
  dff       df -h                  disk free (no virtual fs)
  lb        lsblk                  block devices
  lba       lsblk +label/avail     block devices with labels & free space

── git ────────────────────────────────────────────────────────
  gs        git status
  gsv       git status --verbose
  ga        git add
  gb        git branch             current branch name
  gbb       git branch             list branches
  gba       git branch --all       list all branches (incl. remote)
  gc        git commit --verbose
  gd        git diff
  gsh       git show
  gl        git log --graph        short decorated log
  gla       git log --oneline      one-line log, all branches
  gll       gl --patch             log with diffs
  gpp       git pull --prune       pull and prune dead remotes
  gcf       git-files-changed      files changed vs main
  ggrep     git grep -nI           search tracked files

── search ─────────────────────────────────────────────────────
  agh       ag --hidden            silver searcher, include dotfiles
  fdh       fd -H --no-ignore-vcs  fd, include hidden/ignored files

── process ────────────────────────────────────────────────────
  pst       ps --forest            process tree (all users)
  psu       ps-user                process tree (current user)

── network ────────────────────────────────────────────────────
  sss       ss -ltpn               listening TCP sockets

── tmux ───────────────────────────────────────────────────────
  ta        tmux attach
  td        tmux detach

── date/time ──────────────────────────────────────────────────
  datum     20260306               compact date
  datumm    2026-03-06             iso date
  today     2026-03-06 (06 Mar)    date with short month
  now       iso-8601 timestamp     date -Iseconds
  noww      2026-03-06_143021      file-safe timestamp
  kl        14:30                  current time
  nu        time + date + week     quick overview
  vecka     v.10: mon - sun        week number to date range

── misc ───────────────────────────────────────────────────────
  c         clear
  gdiff     diff --color -u        coloured unified diff
  rs        rsync -av              rsync with progress
  trn       tr -d "\n"             strip newlines
  nvi       nvim -u ~/.vimrc       neovim with vim config
  h         hyprctl                hyprland control
  hexit     hyprctl dispatch exit  exit hyprland
  k         kubectl                kubernetes shorthand
  ys        yay -Syu               system upgrade (Arch)
  eop       eval $(op signin)      sign in to 1Password CLI
  nargs     xargs per line         run command for each stdin line
HALP
}

# Init aliases
config_aliases
