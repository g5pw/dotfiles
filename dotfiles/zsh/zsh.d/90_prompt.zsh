## ask me 'do you wish to see all XX possibilities' before menu selection
export LISTPROMPT=''

## SPROMPT - the spelling prompt
export SPROMPT='zsh: correct %F{red}'%R'%f to %F{green}'%r'%f? (%F{green}[Y]%fes/%F{red}[N]%fo/%F{yellow}[E]%fdit/%F{cyan}[A]%fbort) '

export ZCALCPROMPT="$FX[bold]$FG[208]%1v$FX[no-bold]$FG[111] ⫸ $FX[reset] "

export PROMPT_EOL_MARK='%K{red} %k'

zinit wait lucid for \
    pick"manydots-magic" compile"manydots-magic" knu/zsh-manydots-magic \
    OMZP::dircycle/dircycle.plugin.zsh \
    pick'autopair.zsh' nocompletions hlissner/zsh-autopair

# fish-like history search
zinit load zsh-users/zsh-history-substring-search
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=214,bold'

# bind UP and DOWN arrow keys
bindkey "\e[A" history-substring-search-up
bindkey "\e[B" history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# bindkey "^J" insert-cycledleft
# bindkey "^K" insert-cycledright

prompt_my_docker_context () {
    local docker_context=$(docker context show)
    if [ "$docker_context" != "default" ]; then
	p10k segment -i '' -f blue -t "$docker_context"
    fi
}

eval "$(zoxide init zsh)"
