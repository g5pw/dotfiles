#!/usr/bin/env zsh

alias gaa='git add -A'
alias gshp='git am --show-current-patch'
alias gap='git add -p'
alias gasha='git stash apply'
alias gash='git stash'
alias gashl='git stash list'
alias gashp='git stash pop'
alias gau='git add -u'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbr='git branch -r'
alias gbD='git branch -D'
alias gb='git branch -vv'
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
alias gdc='git diff --cached --'
alias gd='git diff --'
alias gdt='git difftool'
alias gdw='git diff --word-diff'
alias gfa='git fetch --all'
alias gf='git fetch'
alias gfr='git fetch && git rebase'
alias g='git'
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
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grb='git rebase'
alias grbi='git rebase --interactive'
alias gr='git remote -v'
alias grm='git rm'
alias grs='git reset --'
alias grsh='git reset --hard'
alias grsl='git reset HEAD~'
alias grsp='git reset --patch --'
alias gsf='git_show_affected_files'
alias gsb='git show-branch'
alias gsh='git show'
alias gsm='git show --summary'
alias gss='git stash'
alias gssp='git stash pop'
alias gt='git tag'
alias ghelp='git_help_aliases'

function git_help_aliases() {
    if [ -z $1 ]; then
	alias | grep git | tr '=' '\t' | tr -d "'"
    else
    	alias | grep git | tr '=' '\t' | tr -d "'" | grep "$1"
    fi
}

export forgit_log=gli
export forgit_diff=gdi
export forgit_add=ga
export forgit_stash_show=gssi
export forgit_restore=gci
export forgit_cherry_pick=gcpi
export forgit_rebase=gri

export FORGIT_COPY_CMD="xclip -i -selection clipboard"
zinit ice patch"$HOME/.zsh/_patches/remove-git-status.patch"
zinit light wfxr/forgit

FORGIT_STASH_FZF_OPTS='
--bind="ctrl-alt-d:reload(git stash drop $(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)"
'
FORGIT_LOG_FZF_OPTS='
--bind="ctrl-e:execute(echo {} |grep -Eo [a-f0-9]+ |head -1 |xargs git show |vim -)"
'
FORGIT_ADD_FZF_OPTS='
--bind="ctrl-p:execute(git add --patch {3} < /dev/tty > /dev/tty 2>&1)"
'

if type gh &>/dev/null; then
		gh completion -s zsh > $ZDOTDIR/functions/_gh
fi

zinit ice from"gh-r" as"program" pick"delta*/delta"
zinit light dandavison/delta
