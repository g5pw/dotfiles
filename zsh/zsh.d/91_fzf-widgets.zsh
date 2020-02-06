zinit load ytet5uy4/fzf-widgets

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

local fzf_widgets_prefix="^e"

# Map widgets to key
bindkey "${fzf_widgets_prefix}"  fzf-select-widget
bindkey "${fzf_widgets_prefix}c" fzf-change-directory
bindkey "${fzf_widgets_prefix}n" fzf-change-named-directory
bindkey "${fzf_widgets_prefix}f" fzf-edit-files
bindkey "${fzf_widgets_prefix}k" fzf-kill-processes
bindkey "${fzf_widgets_prefix}s" fzf-exec-ssh
bindkey "^\\"  fzf-change-recent-directory
bindkey "^xf" fzf-insert-files
bindkey "^xd" fzf-insert-directory
bindkey "^xn" fzf-insert-named-directory

## Git
bindkey "${fzf_widgets_prefix}g"  fzf-select-git-widget
bindkey "${fzf_widgets_prefix}ga" fzf-git-add-files
bindkey "${fzf_widgets_prefix}gc" fzf-git-change-repository

# GitHub
bindkey "${fzf_widgets_prefix}h"  fzf-select-github-widget
bindkey "${fzf_widgets_prefix}hs" fzf-github-show-issue
bindkey "${fzf_widgets_prefix}hc" fzf-github-close-issue

## Docker
bindkey "${fzf_widgets_prefix}d"  fzf-select-docker-widget
bindkey "${fzf_widgets_prefix}dc" fzf-docker-remove-containers
bindkey "${fzf_widgets_prefix}di" fzf-docker-remove-images
bindkey "${fzf_widgets_prefix}dv" fzf-docker-remove-volumes

# Enable Exact-match by fzf-insert-history
FZF_WIDGET_OPTS[insert-history]='--exact'


fzf-insert-git-sha() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    __fzf::widget::print 'fzf-git-checkout-branch: Not a git repository'
    return 1
    fi

    cmd="git show --color=always {2}"

    __fzf::widget::init || return 1

    git log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr' | \
    __fzf::widget::select $FZF_WIDGET_OPTS[git-checkout-branch] +s +m \
	--ansi \
	--tiebreak=index \
	--preview=$cmd | \
    cut -d' ' -f 2 | \
    __fzf::widget::insert
}

zle -N fzf-insert-git-sha
bindkey "${fzf_widgets_prefix}l"  fzf-insert-git-sha
