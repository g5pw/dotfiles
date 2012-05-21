## set prompts ####
export PS1=$'%F{cyan}%n%f@%F{red}%m%f:%F{blue}%~%f:%F{yellow}%*%f%# '
export PROMPT2="%F{red}%_%F{green} ➣ %f"

export RPROMPT=$'%(?..[ %B%?%b ])'

## ask me 'do you wish to see all XX possibilities' before menu selection
export LISTPROMPT=''

## SPROMPT - the spelling prompt
export SPROMPT='zsh: correct %F{red}'%R'%f to %F{green}'%r'%f? (%F{green}[Y]%fes/%F{red}[N]%fo/%F{yellow}[E]%fdit/%F{cyan}[A]%fbort) '

export ZCALCPROMPT="%B%F{red}%1v%b%F{blue} ⫸ %f "
