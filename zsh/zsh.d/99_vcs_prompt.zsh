#Change RPROMPT to display VCS information when it exists
autoload -Uz vcs_info

# Disable unused VCS
zstyle ':vcs_info:*' enable git svn hg bzr

zstyle ':vcs_info:*' stagedstr '%F{28}◉'
zstyle ':vcs_info:*' unstagedstr '%F{11}⦿'
zstyle ':vcs_info:*' actionformats '%F{red}[%F{green}%b|%a%F{red}]%F{magenta}(%c%u%m%F{magenta})%f'
zstyle ':vcs_info:*' formats "$BG[123]⮀$FG[069] %s%f $BG[229]$FG[123]⮀ $FG[033]$FX[bold]%r$FX[no-bold] $BG[177]$FG[229]⮀$FG[088] ⭠ %b $FX[reset]$FG[177]⮀ %F{magenta}%c%u%m "
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' use-prompt-escapes true
zstyle ':vcs_info:git+set-message:*' hooks git_check_unstaged_files

function +vi-git_check_unstaged_files() {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then;
	hook_com[misc]=$hook_com[misc_orig]
    else
	hook_com[misc]="%F{red}●$hook_com[misc_orig]"
    fi
}

precmd() {
    vcs_info
}

export RPROMPT=$'$FG[000]%(?..$FG[007]$BG[196]$FX[bold] ✘ %?$FX[no-bold]$FG[196]) ${vcs_info_msg_0_}$FX[reset]'
