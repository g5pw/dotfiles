# Include user profile
if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi

## (( ${+*} )) = if variable is set don't set it anymore
(( ${+USER} )) || export USER=$USERNAME
(( ${+HOSTNAME} )) || export HOSTNAME=$HOST
(( ${+EDITOR} )) || export EDITOR=`which vim`
(( ${+VISUAL} )) || export VISUAL=`which vim`
(( ${+FCEDIT} )) || export FCEDIT=`which vim`
(( ${+PAGER} )) || export PAGER=`which less`
(( ${+LESSCHARSET} )) || export LESSCHARSET='utf-8' ## charset for pager
#Less syntax coloring
(( ${+LESSOPEN} )) || export LESSOPEN="| /opt/local/bin/src-hilite-lesspipe.sh %s"
(( ${+LESS} )) || export LESS=' -R  '

## functions for displaying neat stuff in *term title
case $TERM in
    mrxvt|rxvt|rxvt-unicode|(dt|k|a|E)term|screen|xterm*)
    ## display user@host and full dir in *term title
    precmd () {
	print -Pn "\033]0;%n@%m%#  %~ %l  %w :: %T\a"
    }
    ## display user@host and name of current process in *term title
    preexec () {
	print -Pn "\033]0;%n@%m%#  <$1>  %~ %l  %w :: %T\a"
    }
    ;;
esac
