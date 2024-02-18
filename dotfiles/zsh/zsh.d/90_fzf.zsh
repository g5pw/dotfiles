alias pw="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="
--bind='ctrl-o:execute(emacsclient -nw {})+abort'
--bind='ctrl-f:preview-page-down,ctrl-e:preview-down'
--bind='ctrl-b:preview-page-up,ctrl-y:preview-up'
--bind='ctrl-p:page-up,ctrl-n:page-down'
"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER=''

bindkey '\e[Z' fzf-completion

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

if which fd &>/dev/null; then
    # Use fd (https://github.com/sharkdp/fd) instead of the default find
    # command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    _fzf_compgen_path() {
	fd --hidden --follow --exclude ".git" . "$1"
    }

    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
    }

    export FZF_DEFAULT_COMMAND='fd --type file'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
