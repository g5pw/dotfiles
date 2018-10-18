#!/usr/bin/env zsh

# Load zsh-autosuggestions
[ -d $ZDOTDIR/zsh-autosuggestions ] || exit 255

source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
export ZSH_AUTOSUGGEST_USE_ASYNC='yes'

# Bindings
bindkey "^o" autosuggest-execute
