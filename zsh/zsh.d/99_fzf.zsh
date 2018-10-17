source /usr/share/fzf/shell/key-bindings.zsh

alias p="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(emacsclient -nw {})+abort'"
