bindkey '^P' push-input

bindkey "^Xi" incremental-complete-word ## C-x-i

## file rename magick
bindkey "^[m" copy-prev-shell-word

# If AUTO_PUSHD is set, Meta-p pops the dir stack
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'

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
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

insert_caffeinate () { zle beginning-of-line; zle -U "caffeinate " }
zle -N insert-caffeinate insert_caffeinate
bindkey "^[c" insert-caffeinate

# Undo completion
bindkey "^[u" undo

bindkey -M vicmd v edit-command-line

bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (fils and directories)
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories))
