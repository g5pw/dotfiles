bindkey '^P' push-input

bindkey "^Xi" incremental-complete-word ## C-x-i

## file rename magick
bindkey "^[m" copy-prev-shell-word

# If AUTO_PUSHD is set, Meta-p pops the dir stack
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'

bindkey "\ef" insert-files ## Alt-f

bindkey "^X^Z" predict-on ## C-x C-z
bindkey "^Z" predict-off ## C-z
zstyle ':predict' verbose true
zstyle ':predict' toggle true

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