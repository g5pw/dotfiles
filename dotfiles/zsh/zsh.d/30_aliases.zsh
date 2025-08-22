## aliases ####

for cmd in find fd usql; do
    alias $cmd="noglob ${cmd}"
done

for cmd in jj man mkdir; do
    alias $cmd="nocorrect ${cmd}"
done

# Interactive coreutils
alias cp="nocorrect ${GIT_EXPAND} cp -i"
alias mv="nocorrect ${GIT_EXPAND} mv -i"
alias rm="nocorrect ${GIT_EXPAND} rm -i"

# One letter aliases
alias e="${GIT_EXPAND}emacsclient -t"
alias h='history'
alias l='ls'
alias n='numbat'
alias o='${GIT_EXPAND}open'
alias s=jj_or_git_status

alias cat="${GIT_EXPAND}bat"
alias cf="${GIT_EXPAND}clang-format -i"
alias cg="cargo"
alias ds='dirs'
alias dsv='dirs -v'
alias dsc='dirs -c'
alias du1='du -hs *(/)' ## du with depth 1
alias ea='$EDITOR $ZDOTDIR/zsh.d/30_aliases.zsh && source $ZDOTDIR/zsh.d/30_aliases.zsh'
alias ef='edit_function'
alias ez='$EDITOR $ZDOTDIR/.zshrc;src'
alias en="${GIT_EXPAND}emacsclient -c -n"
alias ec="${GIT_EXPAND}emacsclient -n"
alias JUSTFUCKINGDOIT='sudo -p "Oh, come on... alright, gimme your password:" $(fc -ln -1)'
alias mtr='trip -u'
alias grep='rg -uuu'
alias gp='gopass'
alias tig="${GIT_EXPAND} gitui"

alias l.='ls -a'
alias ll.='ls -al'
alias ll='ls -l'
if type eza &> /dev/null; then
    alias ll.='ls -al --git'
    alias ll='ls -l --git'
    alias ls='eza -hF --icons --color=auto'
fi

alias lstty='tio --list'
alias less=$PAGER
alias zless=$PAGER
alias mg='emacsclient -t -c --eval '"'"'(progn (let ((display-buffer-alist `(("^\\*magit: " display-buffer-same-window) ,display-buffer-alist))) (magit-status)) (delete-other-windows))'"' "
alias myip='curl ifconfig.me/ip'
alias rgrep='grep -r'
alias servethis='python -m http.server'
alias tree='erd'
alias vi="$GIT_EXPAND$EDITOR"
alias view="$GIT_EXPAND$EDITOR -R"
alias vim="$GIT_EXPAND$EDITOR"
alias uq="usql"
alias ww="wormhole-william"
alias wwpaste="ww receive"
alias wwcopy="ww send --text -"

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
