# Load zsh-autosuggestions
[ -d $ZDOTDIR/zsh-autosuggestions ] || exit 255

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
export ZSH_AUTOSUGGEST_USE_ASYNC='yes'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30

source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

# Bindings
bindkey "^o" autosuggest-execute
