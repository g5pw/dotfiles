# enable extended glob
setopt extended_glob

# Include files from zsh.d directory
for file in $ZDOTDIR/zsh.d/*.zsh^*.disabled; do
    source $file
done

# Useful commands
function rand() { exec $RANDOM % $1; }

# SCM-Breeze load
[ -s /opt/local/share/scm_breeze/scm_breeze.sh ] && source /opt/local/share/scm_breeze/scm_breeze.sh

#Load fasd
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# load zsh-fuzzy-match
[ -d $ZDOTDIR/zsh-fuzzy-match/ ] && source $ZDOTDIR/zsh-fuzzy-match/fuzzy-match.zsh

# load highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(brackets main)
[ -d $ZDOTDIR/zsh-syntax-highlighting/ ] && source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=56'
ZSH_HIGHLIGHT_STYLES[alias]='fg=35'
ZSH_HIGHLIGHT_STYLES[function]='fg=28'

# fish-like history search
[ -d $ZDOTDIR/zsh-history-substring-search/ ] && source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=220,bold'

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

if [[ -z $SILENT || $SHLVL -lt 2 ]]; then
    cowsay -f "$(ls /opt/local/share/cowsay/cows/*.cow | unsort 2>/dev/null | head -1)" "$(fortune -s)"
fi
