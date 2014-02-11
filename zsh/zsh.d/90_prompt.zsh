## set prompts ####
zstyle  ':prompt:rtab' fish yes
mode_color=178
battery='$BG[239]$(bat_status)$FG[239] '
user_host='$BG[060]⮀ $FG[007]$FX[bold]%n$FX[no-bold]$FG[060] '
dir='$BG[075]⮀ $FG[000]$(rtab)$FG[075] '
clock='$BG[204]⮀$FG[228]%* '
export PROMPT=$battery$user_host$dir$clock'$FX[reset]$FG[204]⮀ $FG[$mode_color]%#$FX[reset] '
export PROMPT2='$FG[131]%_$FG[121] ➣ $FX[reset]'

## ask me 'do you wish to see all XX possibilities' before menu selection
export LISTPROMPT=''

## SPROMPT - the spelling prompt
export SPROMPT='zsh: correct %F{red}'%R'%f to %F{green}'%r'%f? (%F{green}[Y]%fes/%F{red}[N]%fo/%F{yellow}[E]%fdit/%F{cyan}[A]%fbort) '

export ZCALCPROMPT="$FX[bold]$FG[208]%1v$FX[no-bold]$FG[111] ⫸ $FX[reset] "

function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
      mode_color=037
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
