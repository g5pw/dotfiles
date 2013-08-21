## aliases ####
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
alias c='clear'
alias calc='noglob calc'
alias cdiff='colordiff'
alias cp='nocorrect cp -i'
alias ds='dirs'
alias dss='dirs -v'
alias du1='du -hs *(/)' ## du with depth 1
alias ea='$EDITOR $ZDOTDIR/zsh.d/30_aliases.zsh && source $ZDOTDIR/zsh.d/30_aliases.zsh'
alias ef='edit_function'
alias find='noglob find'
alias fu='sudo $( fc -ln -1)'
alias grep='grep --colour'
alias gvim='gvim -U ~/.gvimrc'
alias h='history'
alias heroku="heroku-1.9"
alias ip='curl ifconfig.me/ip'
alias ipfwls="sudo ipfw -atN list"
alias ls='ls -hF --color=auto'
alias l.='ls -A'
alias l='ls'
alias ll.='ls -al'
alias ll='ls -l'
alias lswifi='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -s | sort -k 3'
alias less=$PAGER
alias zless=$PAGER
alias man='nocorrect man'
alias memacs='/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs'
alias memacsclient='/Applications/MacPorts/Emacs.app/Contents/MacOS/bin/emacsclient'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias mmv='noglob zmv -W'
alias msp430-cgdb='cgdb -d msp430-gdb'
alias o='open'
alias octave='octave -q'
alias pi='portindex'
alias p='noglob caffeinate port'
alias psy="sudo port sync"
alias rm='nocorrect rm -i'
alias rgrep='grep -r'
alias rm="rm -i"
alias serverhere='python -m SimpleHTTPServer'
alias sp="noglob caffeinate sudo port"
alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias t='tree'
alias u='uptime'
alias v='f -t -e vim -b viminfo'
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
