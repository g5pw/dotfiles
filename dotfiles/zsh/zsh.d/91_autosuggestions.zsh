# Load zsh-autosuggestions
zinit load zsh-users/zsh-autosuggestions

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242' \
       ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30

# Bindings
bindkey "^o" autosuggest-execute
