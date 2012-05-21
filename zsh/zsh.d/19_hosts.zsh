#Change RPROMPT to display VCS information when it exists
autoload -Uz vcs_info

# Disable unused VCS
zstyle ':vcs_info:*' enable git svn hg

zstyle ':vcs_info:*' stagedstr "%F{yellow}+%f"
zstyle ':vcs_info:*' unstagedstr "%F{green}!%f"
zstyle ':vcs_info:*' actionformats '%F{red}[%F{green}%b|%a%F{red}]%F{magenta}(%c%u%F{magenta})%f'
zstyle ':vcs_info:*' formats '%F{blue}%s%f:%F{red}[%F{green}%b%F{red}]%F{magenta}(%c%u%F{magenta})%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' use-prompt-escapes true

precmd() {
    print -Pn  "\033]0;%~\007"
    psvar=()
    vcs_info
    [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
}
export RPROMPT='%(1v.%F{red} ${vcs_info_msg_0_} %f.) %(?..[ %B%?%b ])'
