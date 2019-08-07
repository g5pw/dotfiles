# fish-like history search
zplugin light 'zsh-users/zsh-history-substring-search'

export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=214,bold'

# bind UP and DOWN arrow keys
bindkey "\e[A" history-substring-search-up
bindkey "\e[B" history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
