## ask me 'do you wish to see all XX possibilities' before menu selection
export LISTPROMPT=''

## SPROMPT - the spelling prompt
export SPROMPT='zsh: correct %F{red}'%R'%f to %F{green}'%r'%f? (%F{green}[Y]%fes/%F{red}[N]%fo/%F{yellow}[E]%fdit/%F{cyan}[A]%fbort) '

export ZCALCPROMPT="$FX[bold]$FG[208]%1v$FX[no-bold]$FG[111] ⫸ $FX[reset] "

export PROMPT_EOL_MARK='%K{red} %k'

function zle-keymap-select {
    zle reset-prompt
}

zle -N zle-keymap-select

zinit wait lucid for \
    ajeetdsouza/zoxide \
    pick"manydots-magic" compile"manydots-magic" knu/zsh-manydots-magic \
    trackbinds bindmap'\e[1\;6D -> \\e[1\;5A; \e[1\;6C -> \\e[1\;5B' pick'dircycle.zsh' michaelxmcbride/zsh-dircycle \
    pick'autopair.zsh' nocompletions hlissner/zsh-autopair
