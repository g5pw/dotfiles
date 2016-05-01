# Include files from zsh.d directory
for file in $ZDOTDIR/zsh.d/*.zsh; do
    source $file
done

# Useful commands
function rand() { exec $RANDOM % $1; }

# Useful command similar to xargs
autoload -U zargs

# SCM-Breeze load
[ -s /opt/local/share/scm_breeze/scm_breeze.sh ] && source /opt/local/share/scm_breeze/scm_breeze.sh

#Load fasd
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# load highlighting
zstyle ':zsh-syntax-highlighting:*'	 enabled		    main brackets
zstyle ':zsh-syntax-highlighting:main:*' history-expansion	    fg=56
zstyle ':zsh-syntax-highlighting:main:*' alias			    fg=35
zstyle ':zsh-syntax-highlighting:main:*' function		    fg=28
zstyle ':zsh-syntax-highlighting:main:*' double-hyphen-option	    fg=140
zstyle ':zsh-syntax-highlighting:main:*' single-hyphen-option	    fg=61
zstyle ':zsh-syntax-highlighting:main:*' back-quoted-argument	    fg=147
[ -d $ZDOTDIR/zsh-syntax-highlighting/ ] && source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fish-like history search
[ -d $ZDOTDIR/zsh-history-substring-search/ ] && source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=220,bold'

# Load ZAW
[ -d $ZDOTDIR/zaw/ ] && source $ZDOTDIR/zaw/zaw.zsh
zstyle ':filter-select:highlight' matched   fg=yellow,standout
zstyle ':filter-select:highlight' title	    fg=cyan,underline
zstyle ':filter-select' max-lines -10 # use $LINES - 10 for filter-select
zstyle ':filter-select' rotate-list yes # enable rotation for filter-select
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search
zstyle ':filter-select' extended-search yes # see below

# Load zsh-autosuggestions
[ -d $ZDOTDIR/zsh-autosuggestions ] && source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey "^[e" autosuggest-execute


# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

[ -r $HOME/.iterm2_shell_integration.zsh ] && source $HOME/.iterm2_shell_integration.zsh
