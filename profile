# Set locale
export LANG=it_IT.UTF-8 LC_MESSAGES=en_US.UTF-8

# Export variables
if type exec_scmb_expand_args &> /dev/null; then
    export EDITOR="exec_scmb_expand_args nvim"
else
    export EDITOR="nvim"
fi
export PAGER=less
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
if [[ -z $XDG_RUNTIME_DIR ]]; then
    export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
else
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh
fi
