
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

function jj_or_git_status() {
    if jj root &> /dev/null; then
        jj status && printf '\u2550%.0s' {1..$COLUMNS} && printf '\n' && jj log
    elif git rev-parse --is-inside-work-tree &> /dev/null; then
        gs
    else
        ls -alh
    fi
}
