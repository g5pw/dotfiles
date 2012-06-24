# Completion options
zstyle ':completion:*' completer _expand _complete _correct _approximate _prefix _history _ignored

# Sort completion list by name
zstyle ':completion:*' file-sort modification reverse

# Open the select menu if there are more than 3 completions
zstyle ':completion:*:default' menu select=3 yes

# Show some color
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## case-insensitive,partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

## allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion::approximate*:*' prefix-needed false

# String to separate options from description
zstyle ':completion:*' list-separator '#'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

## offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## insert all expansions for expand completer
zstyle ':completion::expand:*' tag-order all-expansions

## ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

## filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.(o|c~|old|pro|zwc)' '*~'


# Disable named-directories completion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

## on processes completion complete all user processes
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' force-list always

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Search only 50 items in history
zstyle ':completion:*:history-words' range 5:10

# Separate man page sections.
zstyle ':completion:*:manuals' separate-sections true

## formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*' prompt 'Alternatives %e:'
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	    
zstyle ':completion:*:my-accounts' users-hosts $my_accounts

# only java files for javac
zstyle ':completion:*:javac:*' files '*.java'

# no binary files for vi or textmate
zstyle ':completion:*:vi:*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
zstyle ':completion:*:mate:*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
zstyle ':completion:*:vim:*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
zstyle ':completion:*:gvim:*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
# no binary files for less
zstyle ':completion:*:less:*' ignored-patterns '*.(o|a|so|dvi|fig|out|class|pdf|ps|pyc)'
zstyle ':completion:*:zless:*' ignored-patterns '*.(o|a|so|dvi|fig|out|class|pdf|ps|pyc)'
# tar files
zstyle ':completion:*:tar:*' files '*.tar|*.tgz|*.tz|*.tar.Z|*.tar.bz2|*.tZ|*.tar.gz'
# latex to the fullest
# for printing
zstyle ':completion:*:xdvi:*' files '*.dvi'
zstyle ':completion:*:dvips:*' files '*.dvi'
# Group relatex matches:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:-command-:*:(commands|builtins|reserved-words-aliases)' group-name commands

complete-with-dots() {
    echo -n "\e[31m...\e[0m"
    zle complete-word
    zle redisplay
}
zle -N complete-with-dots
bindkey "^I" complete-with-dots

# Complete word and try to complete again
bindkey -M menuselect '^o' accept-and-infer-next-history
