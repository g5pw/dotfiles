## aliases ####
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
alias c='clear'
alias calc='nocorrect noglob calc'
alias cdiff='colordiff'
alias cp='nocorrect cp -i'
alias ds='dirs'
alias dsv='dirs -v'
alias dsc='dirs -c'
alias du1='du -hs *(/)' ## du with depth 1
alias ea='$EDITOR $ZDOTDIR/zsh.d/30_aliases.zsh && source $ZDOTDIR/zsh.d/30_aliases.zsh'
alias ef='edit_function'
alias ez='$EDITOR $ZDOTDIR/.zshrc;src'
alias e="emacsclient -t -a ''"
alias eb="emacsbare"
alias ec="emacsclient -c -n -a ''"
alias emacsbare="emacs -nw -Q --eval \"(load-theme 'solarized-dark)\""
alias find='noglob find'
alias j='jobs'
alias JUSTFUCKINGDOIT='sudo -p "Oh, come on... alright, gimme your password:" $(fc -ln -1)'
alias grep='grep --colour'
alias h='history'
alias heroku="heroku-1.9"
alias lsipfw="sudo ipfw -atN list"
alias l.='ls -A'
alias l='ls'
alias ll.='ls -al'
alias ll='ls -l'
alias llusb="system_profiler SPUSBDataType"
alias ls='ls -hF --color=auto'
alias lscom="python -m serial.tools.list_ports"
alias lswifi='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -s | sort -rnk 3'
alias less=$PAGER
alias zless=$PAGER
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias msp430-cgdb='cgdb -d msp430-gdb'
alias myip='curl ifconfig.me/ip'
alias o='open'
alias octave='octave -q'
alias pi='portindex'
alias p='noglob port-wrapper'
alias pstree='pstree -g 3'
alias psy="sudo port sync"
alias rg='ranger'
alias rm='nocorrect rm -i'
alias rgrep='grep -r'
alias servethis='python -m http.server'
alias u='uptime'
alias v='f -t -e vim -b viminfo'
alias vi='vim'

# TaskWarrior aliases
if which task &> /dev/null; then
    alias t='nocorrect noglob task'
    alias task='nocorrect noglob task'
    alias tl="nocorrect noglob task list"
    alias ta="nocorrect noglob task add"
    alias td="nocorrect noglob task done"
fi

# The many forms of zmv.
alias mmv='noglob zmv -W'
alias zmv="zmv -wM"
alias zcp="zmv -wC"
alias zln="zmv -wL"

alias wchat="weechat"
alias w="ansiweather"
alias y='tree'

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
alias -g C='|colout -T ${XDG_CONFIG_HOME:-~/.config}/colout/themes/'
alias -g P='|peco|'

# Suffix aliases
alias -s tex=vim
alias -s txt=vim
