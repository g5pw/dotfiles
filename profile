# Set locale
export LANG=en_US.UTF-8

# Export variables
export EDITOR=`which vim`
export PAGER=`which less`
export VISUAL=$EDITOR
export FCEDIT=$EDITOR
export LESSCHARSET='utf-8' ## charset for pager
#Less syntax coloring
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS='-ReiJW'

export GREP_OPTIONS="-n"

export PATH="$HOME/.cabal/bin:$HOME/.go/bin:$HOME/bin:$PATH"
