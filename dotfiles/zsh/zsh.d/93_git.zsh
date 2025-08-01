#!/usr/bin/env zsh

alias gaa='git add -A'
alias gap='git add -p'
alias gas='git am --show-current-patch'
alias gasha='git stash apply'
alias gash='git stash'
alias gashl='git stash list'
alias gashp='git stash pop'
alias gau='git add -u'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbr='git branch -r'
alias gbD='git branch -D'
alias gbl='git blame'
alias gbm='git branch -m'
alias gca='git_commit_all'
alias gcef='git clean -fd'
alias gce='git clean'
alias gcf='git commit --fixup'
alias gc='git commit'
alias gch='git commit -C HEAD'
alias gcl='git clone'
alias gcm='git commit --amend'
alias gcmh='git commit --amend -C HEAD'
alias gcob='git checkout -b'
alias gco='git checkout'
alias gcop='git checkout --patch'
alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'
alias gcv='git commit --verbose'
alias gd='git diff --'
alias gdc='git diff --cached --'
alias gdcs='git diff --cached --ignore-all-space --'
alias gdt='git difftool'
alias gds='git diff --ignore-all-space'
alias gdw='git diff --word-diff'
alias gfa='git fetch --all'
alias gf='git fetch'
alias gfr='git fetch && git rebase'
alias gla='git log --graph --pretty="format:\%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --branches'
alias glg='git log --graph --max-count=5'
alias gl='git log --graph --pretty="format:\%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gls='git log --stat --max-count=5'
alias gmff='git merge --ff'
alias gm='git merge'
alias gmnff='git merge --no-ff'
alias gpl='git pull'
alias gpls='git pull && git push'
alias gpsf='git push --force-with-lease'
alias gps='git push'
alias gpst='git push --tags'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias grbi='git rebase --interactive'
alias grbm='git rebase master'
alias grbim='git rebase --interactive master'
alias gr='git remote -v'
alias grm='git rm'
alias grsh='git reset --hard'
alias grsl='git reset HEAD~'
alias grslp='git reset --patch HEAD~ --'
alias grsp='git reset --patch --'
alias gsf='git_show_affected_files'
alias gsb='git show-branch'
alias gsh='git show'
alias gsm='git show --summary'
alias gss='git stash'
alias gssp='git stash pop'
alias gt='git tag'
alias gu='git unstage'
alias ghelp='git_help_aliases'
alias gwip='git add -A && git commit -m "WIP"'

function grs() {
		git reset -q -- "$@" && gs
}

function git_help_aliases() {
    if [ -z $1 ]; then
	alias | grep git | tr '=' '\t' | tr -d "'"
    else
    	alias | grep git | tr '=' '\t' | tr -d "'" | grep "$1"
    fi
}

function git_brunch_or_branch() {
    if [[ $# -ne 0 ]]; then
        git branch "$@"
    else
        git brunch
    fi
}
alias gbv='git_brunch_or_branch'

function git_or_gitu() {
    if [[ $# -ne 0 ]]; then
        git "$@"
    else
        gitu
    fi
}
alias g=git_or_gitu

export forgit_log=gl
export forgit_diff=gdi
export forgit_add=gai
export forgit_reset_head=grh
export forgit_ignore=gi
export forgit_checkout_file=gcf
export forgit_checkout_branch=gb
export forgit_checkout_tag=gct
export forgit_checkout_commit=gcoi
export forgit_revert_commit=grc
export forgit_clean=gci
export forgit_stash_show=gssi
export forgit_cherry_pick=gcpi
export forgit_rebase=gri
export forgit_fixup=gfi

export FORGIT_COPY_CMD="wl-copy"
zinit light wfxr/forgit

export FORGIT_STASH_FZF_OPTS='
--bind="ctrl-alt-d:reload(git stash drop $(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)"
'
export FORGIT_LOG_FZF_OPTS='
--bind="ctrl-e:execute(echo {} |grep -Eo [a-f0-9]+ |head -1 |xargs git show |vim -)"
'
export FORGIT_ADD_FZF_OPTS='
--bind="ctrl-p:execute(git add --patch {3} < /dev/tty > /dev/tty 2>&1)"
'

export FORGIT_DIFF_FZF_OPTS='
--bind="ctrl-a:execute(git add {2})"
--bind="ctrl-p:execute(git add --patch {2} < /dev/tty > /dev/tty 2>&1)"
'

function ga() {
    if [ "$#" -ne 0 ]; then
        git add "$@"
    else
        forgit::add
    fi
}
alias lg=lazygit

function jj_or_git_status() {
    if jj root &> /dev/null; then
        jj status && printf '\u2550%.0s' {1..$COLUMNS} && printf '\n' && jj log
    elif git rev-parse --is-inside-work-tree &> /dev/null; then
        gs
    else
        ls -alh
    fi
}

zinit ice as"program" pick"bin/git-fuzzy"
zinit light bigH/git-fuzzy

alias j="jj"
alias ja="jj absorb"
alias jd="jj diff"
alias jdr="jj diff -r"
alias jg="jj give"
alias jgf="jj git fetch"
alias jgi="jj give-interactive"
alias jgp="jj git push"
alias jl="jj log"
alias jr="jj rebase"
alias jrm="jj rebase -d main@origin"
alias js="jj status"
alias jsp="jj split"

alias lj="lazyjj"
