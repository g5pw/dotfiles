autoload -U compinit && compinit
zmodload -i zsh/complist

# Completion options
zstyle ':completion:*' completer _expand _complete _approximate:-one _ignored \
				_correct _approximate:-many _prefix _history 

# Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache


# Sort completion list by name
zstyle ':completion:*' file-sort modification

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# prefix complete or approximate only
zstyle ':completion:*:prefix:*' completer _complete _approximate:-many

# Open the select menu if there are more than 3 completions
zstyle ':completion:*:default' menu select=3 yes

# Show some color
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## case-insensitive,partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# generate descriptions with magic.
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' auto-description 'specify: %d'

## allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate-one:*' max-errors 1
zstyle -e ':completion:*:approximate-many:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:approximate*:*' prefix-needed false

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
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.(c~|old|zwc)' '*~'


# Disable named-directories completion
zstyle ':completion:*:cd:*' tag-order local-directories named-directories path-directories directory-stack

## on processes completion complete all user processes
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:kill:*:jobs' list-colors 'no=01;31'
zstyle ':completion:*:*:*:*:processes' force-list always

# Don't complete stuff already on the line
zstyle ':completion::complete:(rm|vi|vim):*' ignore-line true

# cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Search only 50 items in history
zstyle ':completion:*:history-words' range 5:10
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes

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
zstyle ':completion::complete:javac:*' files '*.java'

# no binary files for vi, textmate or sublime text
zstyle ':completion::complete:(v|vi|vim|mvim|mate|subl):*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc|zwc)'
# no binary files for less
zstyle ':completion::complete:(less|zless):*' ignored-patterns '*.(o|a|so|dvi|fig|out|class|pdf|ps|pyc)'
# tar files
zstyle ':completion::complete:tar:*' files '*.tar|*.tgz|*.tz|*.tar.Z|*.tar.bz2|*.tZ|*.tar.gz'
# latex to the fullest
# for printing
zstyle ':completion::complete:(xdvi|dvips):*' files '*.dvi'
# Group relatex matches:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:-command-:*:(commands|builtins|reserved-words-aliases)' group-name commands

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

complete-with-dots() {
    echo -n "\e[31m...\e[0m"
    zle complete-word
    zle redisplay
}
zle -N complete-with-dots
bindkey "^I" complete-with-dots

# Complete word and try to complete again
bindkey -M menuselect '^o' accept-and-infer-next-history

# Custom completions:
compdef sp=port
compdef p=port
compdef reload=whichf
compdef edit_function=whichf
compdef ef=whichf
