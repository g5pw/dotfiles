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
