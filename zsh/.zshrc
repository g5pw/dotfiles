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
eval "$(fasd --init auto)"

# load zsh-fuzzy-match
[ -d $ZDOTDIR/zsh-fuzzy-match/ ] && source $ZDOTDIR/zsh-fuzzy-match/fuzzy-match.zsh

# load highlighting
[ -d $ZDOTDIR/zsh-syntax-highlighting/ ] && source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fish-like history search
[ -d $ZDOTDIR/zsh-history-substring-search/ ] && source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=220,bold'

cowsay -f "$(ls /opt/local/share/cowsay/cows/*.cow | unsort 2>/dev/null | head -1)" "$(fortune -s)"
