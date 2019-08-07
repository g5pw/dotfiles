# Load ZAW
zplugin load 'zsh-users/zaw'

zstyle ':filter-select:highlight' matched   fg=yellow,standout
zstyle ':filter-select:highlight' title     fg=cyan,underline
zstyle ':filter-select:highlight' selected  bg=240,bold
zstyle ':filter-select' max-lines -10       # use $LINES - 10 for filter-select
zstyle ':filter-select' rotate-list yes     # enable rotation for filter-select
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes

bindkey -M filterselect '\e' send-break
bindkey -M filterselect '^d' send-break
