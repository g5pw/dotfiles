# fish-like history search
[ -d $ZDOTDIR/zsh-history-substring-search/ ] || exit 255

source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
# export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=220,bold'

# bind UP and DOWN arrow keys
bindkey "\e[A" history-substring-search-up
bindkey "\e[B" history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
