#!/usr/bin/env zsh

export forgit_log=gli
export forgit_diff=gdi
export forgit_add=gai
export forgit_stash_show=gssi
export forgit_restore=gci
export FORGIT_COPY_CMD="xclip -i -selection clipboard"
zinit load wfxr/forgit


zstyle ':zim:git' aliases-prefix 'g'
zinit load zimfw/git

zinit ice from"gh-r" as"program" pick"scmpuff_*/scmpuff" atload'eval "$(scmpuff init -s -a=false)"'
zinit load mroth/scmpuff
