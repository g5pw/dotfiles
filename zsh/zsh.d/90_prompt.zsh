## set prompts ####
bat_status () {
    tick=($FG[124]▁ $FG[125]▂ $FG[226]▃ $FG[227]▄ $FG[228]▅ $FG[150]▆ $FG[149]▇ $FG[148]█)
    conn=`ioreg -n AppleSmartBattery | grep ExternalConnected | awk '{ print $5 }'`
    chrg=`ioreg -n AppleSmartBattery | grep IsCharging | awk '{ print $5 }'`
    # time=`ioreg -n AppleSmartBattery | grep TimeRemaining | awk '{ print $5 }'`
    max=`ioreg -n AppleSmartBattery | grep MaxCapacity | awk '{ print $5 }'`
    cur=`ioreg -n AppleSmartBattery | grep CurrentCapacity | awk '{ print $5 }'`
    full=`ioreg -n AppleSmartBattery | grep FullyCharged | awk '{ print $5 }'`
    pcnt=$(($cur*100 / $max ))
    if [[ $full == 'Yes' ]]; then
	echo -n "$FG[050]⚡$FG[000]"
    elif [[ $chrg == 'Yes' ]]; then
	echo -n "$FG[202]⚡$FG[000]"
    elif [[ $conn != "Yes" ]]; then
	echo -n $tick[$((pcnt / 14 + 1))]
    fi
}

zstyle  ':prompt:rtab' fish yes
battery=$'$BG[239]$(bat_status)$FG[239]'
user_host="$BG[060]⮀ $FG[007]$FX[bold]%n$FX[no-bold]$FG[060]"
dir=$'$BG[075]⮀ $FG[000]$(rtab)$FG[075]'
time="$BG[204]⮀$FG[228]%*"
export PROMPT="$battery $user_host $dir $time $FX[reset]$FG[204]⮀ $FG[178]%#$FX[reset] "
export PROMPT2="$FG[131]%_$FG[121] ➣ $FX[reset]"

## ask me 'do you wish to see all XX possibilities' before menu selection
export LISTPROMPT=''

## SPROMPT - the spelling prompt
export SPROMPT='zsh: correct %F{red}'%R'%f to %F{green}'%r'%f? (%F{green}[Y]%fes/%F{red}[N]%fo/%F{yellow}[E]%fdit/%F{cyan}[A]%fbort) '

export ZCALCPROMPT="$FX[bold]$FG[208]%1v$FX[no-bold]$FG[111] ⫸ $FX[reset] "
