#Change RPROMPT to display VCS information when it exists
autoload -Uz vcs_info

# Disable unused VCS
zstyle ':vcs_info:*' enable git svn hg bzr

zstyle ':vcs_info:*' stagedstr '%F{28}●'
zstyle ':vcs_info:*' unstagedstr '%F{11}●'
zstyle ':vcs_info:*' actionformats '%F{red}[%F{green}%b|%a%F{red}]%F{magenta}(%c%u%F{magenta})%f'
zstyle ':vcs_info:*' formats '%F{blue}%s%f:%F{yellow}%r%F{red}[%F{green}%b%F{red}]%F{magenta}(%c%u%m%F{magenta})%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' use-prompt-escapes true
zstyle ':vcs_info:git+set-message:*' hooks git_unstaged_files

function +vi-git_unstaged_files() {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then;
    	hook_com[misc]=$hook_com[misc_orig]
    else
	hook_com[misc]="%F{red}●$hook_com[misc_orig]"
    fi
}

precmd() {
    vcs_info
}
export RPROMPT='%F{red}${vcs_info_msg_0_}%f%(?.. [ %F{red}%B%?%b%f ])'
