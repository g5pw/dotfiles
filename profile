# Set locale
export LANG=it_IT.UTF-8 LC_MESSAGES=en_US.UTF-8

# Export variables
export EDITOR="nvim"
export PAGER=less
export VISUAL=$EDITOR
export FCEDIT=$EDITOR
export LESSCHARSET='utf-8' ## charset for pager
#Less syntax coloring
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS='-ReiJW'

deluxe_append_to_path() {
	[[ -d $1 ]] && export PATH="$1:${PATH}"
}

deluxe_append_to_path "$HOME/.cabal/bin"
deluxe_append_to_path "$HOME/.go/bin"
deluxe_append_to_path "$HOME/.cargo/bin"
deluxe_append_to_path "$HOME/.local/bin"

unset -f deluxe_append_to_path

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
