# Load zsh-autosuggestions
zplugin light 'zsh-users/zsh-autosuggestions'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
export ZSH_AUTOSUGGEST_USE_ASYNC='yes'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30

# Bindings
bindkey "^o" autosuggest-execute
