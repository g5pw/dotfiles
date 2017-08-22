## set prompts ####
zstyle  ':prompt:rtab' fish yes
mode_color=178
battery='$BG[239]$(bat_status)$FG[239] '
user_host='$FG[236]$BG[141] $FG[16]$FX[bold]%n$FX[no-bold]@%m:%l $FG[141]'
dir='$BG[61] $FG[15]$(rtab)$FG[61] '
clock='$BG[6]$FG[236]%T '
export PROMPT=$user_host$dir$clock'$FX[reset]$FG[6] $FG[$mode_color]%#$FX[reset] '
export PROMPT2='$FG[131]%_$FG[121]  $FX[reset]'

## ask me 'do you wish to see all XX possibilities' before menu selection
export LISTPROMPT=''

## SPROMPT - the spelling prompt
export SPROMPT='zsh: correct %F{red}'%R'%f to %F{green}'%r'%f? (%F{green}[Y]%fes/%F{red}[N]%fo/%F{yellow}[E]%fdit/%F{cyan}[A]%fbort) '

export ZCALCPROMPT="$FX[bold]$FG[208]%1v$FX[no-bold]$FG[111] ⫸ $FX[reset] "

function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
      mode_color=37
    else
      mode_color=178
    fi
    zle reset-prompt
}

function zle-line-finish {
    mode_color=178
}

zle -N zle-keymap-select
zle -N zle-line-finish
