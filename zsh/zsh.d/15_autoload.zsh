# Load interesting modules
zmodload zsh/mapfile
zmodload zsh/mathfunc
zmodload zsh/regex
zmodload zsh/pcre

# Load colors
autoload -U colors && colors

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Can I haz 256 colors?
autoload spectrum && spectrum

# autoload calculator
autoload -U zcalc

# Load a better move!
autoload -U zmv

# Helper function to load zsh hooks
autoload -Uz add-zsh-hook

## This allows incremental completion of a word.
## After starting this command, a list of completion
## choices can be shown after every character you
## type, which you can delete with ^h or DEL.
## RET will accept the completion so far.
## You can hit TAB to do normal completion, ^g to
## abort back to the state when you started, and ^d to list the matches.
autoload -U incremental-complete-word
zle -N incremental-complete-word

## This function allows you type a file pattern,
## and see the results of the expansion at each step.
## When you hit return, they will be inserted into the command line.
autoload -U insert-files
zle -N insert-files

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# # Vi style:
zle -N edit-command-line

# Autoload my functions
autoload -Uz $ZDOTDIR/functions/*(:t)
