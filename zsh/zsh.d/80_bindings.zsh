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

# Rationalize dot in CD command
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert_sudo
bindkey "^[s" insert_sudo

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

bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (fils and directories)
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories))
