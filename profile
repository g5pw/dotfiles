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
export LESS='-RFeiJW'

#custom exports for coloured less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

deluxe_prepend_to_path() {
    [ -d "$1" ] || return 255
    [[ ":$PATH:" != *":$1:"* ]] && PATH="$1:${PATH}"
}

deluxe_prepend_to_path "$HOME/.cabal/bin"
deluxe_prepend_to_path "$HOME/.cargo/bin"
deluxe_prepend_to_path "$HOME/.go/bin"
deluxe_prepend_to_path "$HOME/.npm-global/bin"

deluxe_prepend_to_path "$HOME/.local/bin"

# Use GNU utils if possible
deluxe_prepend_to_path /opt/local/libexec/gnubin
deluxe_prepend_to_path /opt/local/libexec/perl5.12

unset -f deluxe_prepend_to_path

# Python init file
if [ -f ~/.pythonrc ]; then
	export PYTHONSTARTUP="$HOME/.pythonrc"
fi

gpg-connect-agent /bye >/dev/null 2>&1

export GPG_TTY=$(tty)

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
