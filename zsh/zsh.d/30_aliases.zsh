## aliases ####
if type exec_scmb_expand_args &> /dev/null; then
    GIT_EXPAND='exec_scmb_expand_args '
fi
alias c='clear'
alias calc='nocorrect noglob calc'
alias cat='${GIT_EXPAND}bat'
alias cdiff='colordiff'
alias cf="${GIT_EXPAND}clang-format -i"
alias cp='nocorrect cp -i'
alias ds='dirs'
alias dsv='dirs -v'
alias dsc='dirs -c'
alias du1='du -hs *(/)' ## du with depth 1
alias ea='$EDITOR $ZDOTDIR/zsh.d/30_aliases.zsh && source $ZDOTDIR/zsh.d/30_aliases.zsh'
alias ef='edit_function'
alias ez='$EDITOR $ZDOTDIR/.zshrc;src'
alias e="${GIT_EXPAND}emacsclient -t -a \'\'"
alias en="${GIT_EXPAND}emacsclient -c -n -a \'\'"
alias ec="${GIT_EXPAND}emacsclient -n -a \'\'"
alias find='noglob find'
alias fd='noglob fd'
alias j='jobs'
alias JUSTFUCKINGDOIT='sudo -p "Oh, come on... alright, gimme your password:" $(fc -ln -1)'
alias grep='grep --colour'
alias gp='gopass'
alias h='history'
alias heroku="heroku-1.9"
if type exa &> /dev/null; then
    alias l.='exa -a'
    alias l='exa'
    alias ll.='exa -al --git'
    alias ll='exa -l --git'
    alias ls='exa -hF --color=auto'
else
    alias l.='ls -A'
    alias l='ls'
    alias ll.='ls -al'
    alias ll='ls -l'
    alias ls='ls -hF --color=auto'
fi
alias lscom="python3 -m serial.tools.list_ports"
alias lstty='print -l /dev/tty[AU]*'
alias less=$PAGER
alias zless=$PAGER
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias msp430-cgdb='cgdb -d msp430-gdb'
alias myip='curl ifconfig.me/ip'
alias n='${GIT_EXPAND}nnn'
alias o='${GIT_EXPAND}open'
alias octave='octave -q'
alias pstree='pstree -g'
alias rgr='ranger'
alias rm='nocorrect rm -i'
alias rgrep='grep -r'
alias servethis='python -m http.server'
alias u='uptime'
alias vi="$GIT_EXPAND$EDITOR"
alias view="$GIT_EXPAND$EDITOR -R"
alias vim="$GIT_EXPAND$EDITOR"
alias t="${GIT_EXPAND}tig"
alias ta="tmux attach-session -t"
alias tn="tmux new-session -s"

# TaskWarrior aliases
if which task &> /dev/null; then
    alias tw='nocorrect noglob task'
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

# Git aliases
alias gap='git add --patch'
alias gc='git commit'
alias gcm='git commit --amend'
alias gcf='git commit --fixup'
alias gcop='git checkout --patch'
alias gdc='git diff --cached'
alias grsp='git reset --patch --'
alias gpst='git push --tags'
alias grbm='git rebase --autostash origin/master'
alias gpsf='git push'
alias gpsf='git push --force-with-lease'
alias grbi='git rebase --interactive'

## global aliases, this is not good but it's useful
alias -g G='|noglob grep'
alias -g H='|head'
alias -g L='|less'
alias -g N='&>/dev/null'
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
alias -s tex=$EDITOR
alias -s txt=$EDITOR
alias -s git="git clone"

unset GIT_EXPAND
