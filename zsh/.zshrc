# Include files from zsh.d directory
for file in $ZDOTDIR/zsh.d/*.zsh; do
    source $file
done

# Useful commands
function rand() { exec $RANDOM % $1; }

# Useful command similar to xargs
autoload -U zargs

#Load fasd
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# fish-like history search
if [ -d $ZDOTDIR/zsh-history-substring-search/ ]; then
    source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
    export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=220,bold'

    # bind UP and DOWN arrow keys
    bindkey "\e[A" history-substring-search-up
    bindkey "\e[B" history-substring-search-down

    # bind k and j for VI mode
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi

# Load ZAW
if [ -d $ZDOTDIR/zaw/ ]; then
    source $ZDOTDIR/zaw/zaw.zsh
    zstyle ':filter-select:highlight' matched   fg=yellow,standout
    zstyle ':filter-select:highlight' title     fg=cyan,underline
    zstyle ':filter-select' max-lines -10       # use $LINES - 10 for filter-select
    zstyle ':filter-select' rotate-list yes     # enable rotation for filter-select
    zstyle ':filter-select' case-insensitive yes
    zstyle ':filter-select' extended-search yes
fi

# Load zsh-autosuggestions
if [ -d $ZDOTDIR/zsh-autosuggestions ]; then
    source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
fi
bindkey "^[e" autosuggest-execute


[ -r $HOME/.iterm2_shell_integration.zsh ] && source $HOME/.iterm2_shell_integration.zsh
if [[ $TERM == xterm-termite ]]; then
    source /etc/profile.d/vte-2.91.sh
    __vte_osc7
fi

# load highlighting
if [ -d $ZDOTDIR/zsh-syntax-highlighting/ ]; then
    source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
