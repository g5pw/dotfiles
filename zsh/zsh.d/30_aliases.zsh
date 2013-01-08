## aliases ####
alias c='clear'
alias calc='noglob calc'
alias cdiff='colordiff'
alias clj='rlwrap clj'
alias cp='nocorrect cp -i'
alias ds='dirs'
alias dss='dirs -v'
alias du1='du -hs *(/)' ## du with depth 1
alias find='noglob find'
alias grep='grep --colour'
alias gvim='gvim -U ~/.gvimrc'
alias h='history'
alias ip='curl ifconfig.me/ip'
alias ls='ls -hF --color=auto'
alias l.='ls -A'
alias l='ls'
alias ll.='ls -al'
alias ll='ls -l'
alias less=$PAGER
alias zless=$PAGER
alias man='nocorrect man'
alias memacs='/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs'
alias memacsclient='/Applications/MacPorts/Emacs.app/Contents/MacOS/bin/emacsclient'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias msp430-cgdb='cgdb -d msp430-gdb'
alias octave='octave -q'
alias pi='portindex'
alias p='noglob caffeinate port'
alias psy="port sync"
alias rm='nocorrect rm -i'
alias rgrep='grep -r'
alias serverhere='python -m SimpleHTTPServer'
alias sp="noglob caffeinate sudo port"
alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias t='tree'
alias u='uptime'
alias v='vim'
alias vi='vim'
alias vd="vifm"
alias z='$EDITOR $ZDOTDIR/.zshrc;src'
# The many forms of zmv.
alias zmv="zmv -wM"
alias zcp="zmv -wC"
alias zln="zmv -wL"
alias wchat="weechat-curses"

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
alias -s zsh=vim
