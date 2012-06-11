## The maximum number of events stored in the internal history list.
export HISTSIZE=10000

## The maximum number of history events to save in the history file.
export SAVEHIST=9500

#load Mapfile
zmodload zsh/mapfile

# Add Regexp replacing
zmodload zsh/regex

# Load colors
autoload -U colors && colors

## Add PCRE support
zmodload zsh/pcre

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Autoload my functions
autoload -U $ZDOTDIR/functions/*(:t)

# Load 256 colors!
autoload spectrum && spectrum

# Include files from zsh.d directory
for file in $ZDOTDIR/zsh.d/*.zsh^*.disabled; do
    source $file
done

## This allows incremental completion of a word.
## After starting this command, a list of completion
## choices can be shown after every character you
## type, which you can delete with ^h or DEL.
## RET will accept the completion so far.
## You can hit TAB to do normal completion, ^g to            
## abort back to the state when you started, and ^d to list the matches.
autoload -U incremental-complete-word
zle -N incremental-complete-word
bindkey "^Xi" incremental-complete-word ## C-x-i

## file rename magick
bindkey "^[m" copy-prev-shell-word

# If AUTO_PUSHD is set, Meta-p pops the dir stack
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'

## This function allows you type a file pattern,
## and see the results of the expansion at each step.
## When you hit return, they will be inserted into the command line.
autoload -U insert-files
zle -N insert-files
bindkey "\ef" insert-files ## Alt-f

## This set of functions implements a sort of magic history searching.
## After predict-on, typing characters causes the editor to look backward
## in the history for the first line beginning with what you have typed so
## far.  After predict-off, editing returns to normal for the line found.
## In fact, you often don't even need to use predict-off, because if the
## line doesn't match something in the history, adding a key performs
## standard completion - though editing in the middle is liable to delete
## the rest of the line.
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X^Z" predict-on ## C-x C-z
bindkey "^Z" predict-off ## C-z
zstyle ':predict' verbose true
zstyle ':predict' toggle true

# Undo completion
bindkey "\eu" undo

# Rationalize dot in CD command
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Useful commands
function rand() { exec $RANDOM % $1; }

# SCM-Breeze load
[ -s "/Users/g5pw/.scm_breeze/scm_breeze.sh" ] && source "/Users/g5pw/.scm_breeze/scm_breeze.sh"

#load more completions
fpath=($ZDOTDIR/zsh-completions $fpath)

# load ZAW
[ -d $ZDOTDIR/zaw/ ] && source $ZDOTDIR/zaw/zaw.zsh

# load highlighting
[ -d $ZDOTDIR/zsh-syntax-highlighting/ ] && source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fish-like history search
[ -d $ZDOTDIR/zsh-history-substring-search/ ] && source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=203,fg=75,bold'

cowsay -f "$(ls /opt/local/share/cowsay/cows/ | unsort 2>/dev/null | head -1)" "$(fortune -s)"
