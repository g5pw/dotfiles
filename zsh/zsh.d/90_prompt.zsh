autoload -U promptinit; promptinit

prompt spaceship

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false

function zle-keymap-select {
    zle reset-prompt
}

zle -N zle-keymap-select
