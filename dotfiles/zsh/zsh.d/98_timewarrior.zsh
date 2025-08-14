function timewarrior_summary_and_current() {
    if [[ $# -ne 0 ]]; then
        timew "$@"
    else
        timew summary :week :ids && printf '\u2550%.0s' {1..$COLUMNS} && printf '\n' && timew
    fi
}

# TimeWarrior aliases
if type timew &> /dev/null; then
    alias t=timewarrior_summary_and_current
    alias tws='timew summary :week :ids'
fi

# TaskWarrior aliases
if type task &> /dev/null; then
    alias tw='nocorrect noglob task'
    alias task='nocorrect noglob task'
    alias tl="nocorrect noglob task list"
    alias ta="nocorrect noglob task add"
    alias td="nocorrect noglob task done"
fi
