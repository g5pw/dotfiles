# Set locale
export LANG=it_IT.UTF-8 LC_MESSAGES=en_US.UTF-8

# Export variables
export EDITOR=`which vim`
export PAGER=`which less`
export VISUAL=$EDITOR
export FCEDIT=$EDITOR
export LESSCHARSET='utf-8' ## charset for pager
#Less syntax coloring
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS='-ReiJW'

export PATH="$HOME/.cabal/bin:$HOME/.go/bin:$HOME/bin:$PATH"

#add ROOT to python path
if [ -n "$PYTHONPATH" ]; then
	export PYTHONPATH="$PYTHONPATH:/opt/local/lib/root/"
else
	export PYTHONPATH="/opt/local/lib/root/"
fi

# Python init file
if [ -f ~/.pythonrc ]; then
	export PYTHONSTARTUP="$HOME/.pythonrc"
fi

gpg-connect-agent /bye
export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
