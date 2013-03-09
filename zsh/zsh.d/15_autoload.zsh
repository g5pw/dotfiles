#load Mapfile
zmodload zsh/mapfile

# Add Regexp replacing
zmodload zsh/regex

# Load colors
autoload -U colors && colors

## Add PCRE support
zmodload zsh/pcre

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Can I haz 256 colors?
autoload spectrum && spectrum

# autoload calculator
autoload -U zcalc

# Load a better move!
autoload -U zmv

# Autoload my functions
autoload -U $ZDOTDIR/functions/*(:t)

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

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# # Vi style:
zle -N edit-command-line
