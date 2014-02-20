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

#custom exports for coloured less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# enable extended glob
setopt extended_glob
