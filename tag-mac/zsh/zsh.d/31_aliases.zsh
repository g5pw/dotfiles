alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
alias code='/Applications/VSCodium.app/Contents/Resources/app/bin/code'
alias llusb="system_profiler SPUSBDataType"
alias lswifi='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -s | sed 1d | sort -rnk 3'
if which port &> /dev/null; then
    alias psy="sudo port sync"
    alias pi='portindex'
    alias p='noglob port-wrapper'
fi
