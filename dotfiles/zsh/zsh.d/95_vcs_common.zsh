function jj_or_git_status() {
    if jj root &> /dev/null; then
        jj status && printf '\u2550%.0s' {1..$COLUMNS} && printf '\n' && jj log
    elif git rev-parse --is-inside-work-tree &> /dev/null; then
        gs
    else
        ls -alh
    fi
}
