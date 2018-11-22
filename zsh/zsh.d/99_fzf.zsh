source /usr/share/fzf/shell/key-bindings.zsh

alias p="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(emacsclient -nw {})+abort'"

if which fd &>/dev/null; then
    # Prefer using `fd`
    export FZF_DEFAULT_COMMAND='fd --type file --color=always'
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --ansi"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
