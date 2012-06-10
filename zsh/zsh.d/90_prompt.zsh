## set prompts ####
zstyle  ':prompt:rtab' fish yes
export PS1=$'$FG[032]%n$FG[178]@$FG[196]%m$FG[178]:$FG[075]$(rtab)$FG[178]:$FG[228]%*$FG[178]%#$FX[reset] '
export PROMPT2="$FG[131]%_$FG[121] ➣ $FX[reset]"

export RPROMPT="%(?..[ $FX[bold]%?$FX[no-bold] ])"

## ask me 'do you wish to see all XX possibilities' before menu selection
export LISTPROMPT=''

## SPROMPT - the spelling prompt
export SPROMPT='zsh: correct %F{red}'%R'%f to %F{green}'%r'%f? (%F{green}[Y]%fes/%F{red}[N]%fo/%F{yellow}[E]%fdit/%F{cyan}[A]%fbort) '

export ZCALCPROMPT="$FX[bold]$FG[208]%1v$FX[no-bold]$FG[111] ⫸ $FX[reset] "
