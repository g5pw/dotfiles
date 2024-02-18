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

prompt_nix_shell () {
  if [[ -n ${IN_NIX_SHELL} && ${IN_NIX_SHELL} != "0" ]] || [[ ${IN_NIX_RUN} && ${IN_NIX_RUN} != "0" ]]; then
    if [[ -n ${IN_WHICH_NIX_SHELL} ]] then
      NIX_SHELL_NAME=": ${IN_WHICH_NIX_SHELL}"
    fi
    if [[ -n ${IN_NIX_SHELL} && ${IN_NIX_SHELL} != "0" ]]; then
      NAME="shell"
    else
      NAME="run"
    fi
    p10k segment -i $'\uf313' -f '033' -t "${NAME}${NIX_SHELL_NAME}"
  fi
}
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=nix_shell
