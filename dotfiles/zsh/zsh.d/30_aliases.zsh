## aliases ####
if whence scmpuff &> /dev/null; then
    GIT_EXPAND='scmpuff exec -- '
fi
alias c='clear'
alias calc='nocorrect noglob calc'
alias cat="${GIT_EXPAND}bat"
alias cdiff='colordiff'
alias cf="${GIT_EXPAND}clang-format -i"
alias cp="nocorrect ${GIT_EXPAND} cp -i"
alias ds='dirs'
alias dsv='dirs -v'
alias dsc='dirs -c'
alias du1='du -hs *(/)' ## du with depth 1
alias ea='$EDITOR $ZDOTDIR/zsh.d/30_aliases.zsh && source $ZDOTDIR/zsh.d/30_aliases.zsh'
alias ef='edit_function'
alias ez='$EDITOR $ZDOTDIR/.zshrc;src'
alias e="${GIT_EXPAND}emacsclient -t -a ''"
alias en="${GIT_EXPAND}emacsclient -c -n -a ''"
alias ec="${GIT_EXPAND}emacsclient -n -a ''"
alias find='noglob find'
alias fd='noglob fd'
alias f='yazi'
alias j='jobs'
alias JUSTFUCKINGDOIT='sudo -p "Oh, come on... alright, gimme your password:" $(fc -ln -1)'
alias mtr='trip -u'
alias nxu='nix flake update --flake ~nix'
alias grep='rg -uuu'
alias gp='gopass'
alias h='history'
alias tig="${GIT_EXPAND} gitui"
alias t="timew"

alias l='ls'
alias l.='ls -a'
alias ll.='ls -al'
alias ll='ls -l'
if type eza &> /dev/null; then
    alias ll.='ls -al --git'
    alias ll='ls -l --git'
    alias ls='eza -hF --icons --color=auto'
elif type lsd &> /dev/null; then
    alias ls='lsd -hF --color=auto'
fi

alias lscom="python3 -m serial.tools.list_ports"
alias lstty='print -l /dev/tty[AU]*'
alias less=$PAGER
alias zless=$PAGER
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mg='emacsclient -nw -c --eval '"'"'(progn (let ((display-buffer-alist `(("^\\*magit: " display-buffer-same-window) ,display-buffer-alist))) (magit-status)) (delete-other-windows))'"' "
alias mv="nocorrect ${GIT_EXPAND} mv -i"
alias myip='curl ifconfig.me/ip'
alias n='numbat'
alias o='${GIT_EXPAND}open'
alias rm="nocorrect ${GIT_EXPAND} rm -i"
alias rgrep='grep -r'
alias s="git status"
alias servethis='python -m http.server'
alias tree='erd'
alias tug='nocorrect noglob tug'
alias u='uptime'
alias vi="$GIT_EXPAND$EDITOR"
alias view="$GIT_EXPAND$EDITOR -R"
alias vim="$GIT_EXPAND$EDITOR"
alias youtube-dl="noglob youtube-dl"
alias usql="noglob usql"
alias uq="usql"
alias ww="wormhole-william"
alias wwpaste="ww receive"
alias wwcopy="ww send --text -"

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


## global aliases, this is not good but it's useful
alias -g G='|noglob grep'
alias -g H='|head'
alias -g L='|less'
alias -g N='&>/dev/null'
alias -g S='|sort'
alias -g T='|tail'
alias -g UC='|uniq -c'
alias -g US='|sort -u'
alias -g W='|wc -l'
alias -g C='|colout -T ${XDG_CONFIG_HOME:-~/.config}/colout/themes/'
alias -g P='|peco|'
alias -g HLP='--help | bat --plain --language=help'

# Suffix aliases
alias -s tex=$EDITOR
alias -s txt=$EDITOR
alias -s git="git clone"

function ssh_or_sshs() {
    if [[ $# -ne 0 ]]; then
        ssh "$@"
    else
        sshs
    fi
}
alias ssh=ssh_or_sshs

#unset GIT_EXPAND
