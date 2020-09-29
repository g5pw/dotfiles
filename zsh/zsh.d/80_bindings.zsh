# Enable vi shell bindings
bindkey -v

bindkey '^P' push-input
bindkey -M vicmd '^P' push-input

bindkey "^Xi" incremental-complete-word ## C-x-i

## file rename magick
bindkey "^[m" copy-prev-shell-word

# If AUTO_PUSHD is set, Meta-p pops the dir stack
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'
bindkey -M vicmd -s '\ep' 'I^Upopd >/dev/null; dirs -v^M'

bindkey "\ef" insert-files ## Alt-f

autoload predict-on
predict-toggle() { ((predict_on=1-predict_on)) && predict-on || predict-off }
zle -N predict-toggle
bindkey '^Z'   predict-toggle
zstyle ':predict' verbose true
zstyle ':predict' cursor key

# run command line as user root via sudo:
function sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N sudo-command-line
bindkey "^[s" sudo-command-line

# jump behind the first word on the cmdline
# useful to add options.
function jump_after_first_word () {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}
    fi
}
zle -N jump_after_first_word
bindkey "^[o" jump_after_first_word

# insert datetime on key shortcut
function insert-datestamp () { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp
bindkey "^[d" insert-datestamp

# Undo completion
bindkey "^[u" undo

bindkey -M vicmd V edit-command-line

complete-with-dots() {
    echo -n "\e[31m...\e[0m"
    zle complete-word
    zle redisplay
}
zle -N complete-with-dots
bindkey "^I" complete-with-dots

# Complete word and try to complete again
bindkey -M menuselect '^o' accept-and-infer-next-history
