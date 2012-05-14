## aliases ####
alias c='clear'
alias calc='noglob calc'
alias cdiff='colordiff'
alias cp='nocorrect cp -i'
alias dirss='dirs -v'
alias du1='du -hs *(/)' ## du with depth 1
alias find='noglob find'
alias grep='grep --colour'
alias gvim='gvim -U ~/.gvimrc'
alias h='history'
alias l.='ls -A'
alias l='ls'
alias ll.='ls -al'
alias ll='ls -l'
alias ls='ls -G'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias pi='portindex'
alias port='noglob port'
alias rm='nocorrect rm -i'
alias serverhere='python -m SimpleHTTPServer'
alias t='tree'
alias u='uptime'
alias z='$EDITOR ~/.zshrc;src'

## global aliases, this is not good but it's useful
alias -g G='|grep'
alias -g H='|head'
alias -g L='|less'
alias -g N='&>/dev/null&'
alias -g NS='|sort -n'
alias -g RNS='|sort -nr'
alias -g S='|sort'
alias -g T='|tail'
alias -g UC='|uniq -c'
alias -g US='|sort -u'
alias -g W='|wc -l'

# Suffix aliases
alias -s tex=vim

# Emacs.app aliases
alias memacs="/Applications/MacPorts/Emacs.app/MacOS/Emacs"

#Fix annoying typo alias
alias prot="port"
alias sport="sudo port"
