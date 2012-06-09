# Completion options
zstyle ':completion:*' completer _complete _approximate _correct _prefix _expand _history _ignored

# Sort completion list by name
zstyle ':completion:*' file-sort name

## case-insensitive,partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

## offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## insert all expansions for expand completer
zstyle ':completion::expand:*' tag-order all-expansions

## ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

## filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.(o|c~|old|pro|zwc)' '*~'

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

## on processes completion complete all user processes
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' force-list always

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Search only 50 items in history
zstyle ':completion:*:history-words' range 5:10

## formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	    
zstyle ':completion:*:my-accounts' users-hosts $my_accounts

complete-with-dots() {
    echo -n "\e[31m...\e[0m"
    zle complete-word
    zle redisplay
}
zle -N complete-with-dots
bindkey "^I" complete-with-dots

# Complete word and try to complete again
bindkey -M menuselect '^o' accept-and-infer-next-history
