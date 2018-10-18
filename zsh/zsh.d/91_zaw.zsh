#!/usr/bin/env zsh

# Load ZAW
[ -d $ZDOTDIR/zaw/ ] || exit 255

source $ZDOTDIR/zaw/zaw.zsh
zstyle ':filter-select:highlight' matched   fg=yellow,standout
zstyle ':filter-select:highlight' title     fg=cyan,underline
zstyle ':filter-select' max-lines -10       # use $LINES - 10 for filter-select
zstyle ':filter-select' rotate-list yes     # enable rotation for filter-select
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes
