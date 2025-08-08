# Copyright 2025 Google LLC.
# SPDX-License-Identifier: Apache-2.0
# Requires async.zsh: https://github.com/mafredri/zsh-async
# Based on romkatv's comment: https://old.reddit.com/r/zsh/comments/l2y976/_/gkb9y72/

zinit light 'mafredri/zsh-async'

function jj_op() {
  emulate -L zsh
  cd "$1"
  jj --ignore-working-copy --at-op=@ op log -n 1 -T "id.short()" --no-graph 2> /dev/null
}
function jj_op_callback() {
  emulate -L zsh
  if [[ $2 -ne 0 ]]; then
    typeset -g p10k_jj_op=
  else
    typeset -g p10k_jj_op="$3"
  fi
  typeset -g p10k_jj_op_stale= p10k_jj_op_updated=1
  p10k display -r
}
async_start_worker jj_op_worker -u; async_unregister_callback jj_op_worker; async_register_callback jj_op_worker jj_op_callback
function prompt_jj_op() {
  emulate -L zsh -o extended_glob
  (( $+commands[jj]         )) || return
  [[ -n ./(../)#(.jj)(#qN/) ]] || return
  typeset -g p10k_jj_op_stale=1 p10k_jj_op_updated=
  p10k segment -f grey -c '$p10k_jj_op_stale' -e -t '$p10k_jj_op'
  p10k segment -f green -c '$p10k_jj_op_updated' -e -t '$p10k_jj_op' # use `-f 12` for jj colours
  async_job jj_op_worker jj_op $PWD
}
function jj_at() {
  emulate -L zsh
  cd "$1"
  jj --ignore-working-copy --at-op=@ log --no-graph -r @ -T "diff.summary()" 2> /dev/null | awk 'BEGIN {a=0;d=0;m=0} /^A / {a++} /^D / {d++} /^M / {m++} /^R / {m++} /^C / {a++} END {print(a,d,m)}'
}
function jj_at_callback() {
  emulate -L zsh
  if [[ $2 -ne 0 ]]; then
    typeset -g p10k_jj_at_add= p10k_jj_at_del= p10k_jj_at_mod=
  else
    parts=(${(@s: :)3})
    if [[ ${parts[1]} != "0" ]]; then
      typeset -g p10k_jj_at_add="+${parts[1]}"
    else
      typeset -g p10k_jj_at_add=
    fi
    if [[ ${parts[2]} != "0" ]]; then
      typeset -g p10k_jj_at_del="-${parts[2]}"
    else
      typeset -g p10k_jj_at_del=
    fi
    if [[ ${parts[3]} != "0" ]]; then
      typeset -g p10k_jj_at_mod="^${parts[3]}"
    else
      typeset -g p10k_jj_at_mod=
    fi
  fi
  typeset -g p10k_jj_at_stale= p10k_jj_at_updated=1
  p10k display -r
}
async_start_worker jj_at_worker -u; async_unregister_callback jj_at_worker; async_register_callback jj_at_worker jj_at_callback
function prompt_jj_at() {
  emulate -L zsh -o extended_glob
  (( $+commands[jj]         )) || return
  [[ -n ./(../)#(.jj)(#qN/) ]] || return
  typeset -g p10k_jj_at_stale=1 p10k_jj_at_updated=
  p10k segment -f grey -c '$p10k_jj_at_stale' -e -t '$p10k_jj_at_add'
  p10k segment -f green -c '$p10k_jj_at_updated' -e -t '$p10k_jj_at_add'
  p10k segment -f grey -c '$p10k_jj_at_stale' -e -t '$p10k_jj_at_del'
  p10k segment -f red -c '$p10k_jj_at_updated' -e -t '$p10k_jj_at_del'
  p10k segment -f grey -c '$p10k_jj_at_stale' -e -t '$p10k_jj_at_mod'
  p10k segment -f cyan -c '$p10k_jj_at_updated' -e -t '$p10k_jj_at_mod'
  async_job jj_at_worker jj_at $PWD
}
function jj_conflicts() {
  emulate -L zsh
  setopt pipefail
  cd "$1"
  jj --ignore-working-copy --at-op=@ resolve --list 2> /dev/null | wc -l
}
function jj_conflicts_callback() {
  emulate -L zsh
  if [[ $2 -ne 0 ]]; then
    typeset -g p10k_jj_conflicts=
  else
    typeset -g p10k_jj_conflicts="!$3"
  fi
  typeset -g p10k_jj_conflicts_stale= p10k_jj_conflicts_updated=1
  p10k display -r
}
async_start_worker jj_conflicts_worker -u; async_unregister_callback jj_conflicts_worker; async_register_callback jj_conflicts_worker jj_conflicts_callback
function prompt_jj_conflicts() {
  emulate -L zsh -o extended_glob
  (( $+commands[jj]         )) || return
  [[ -n ./(../)#(.jj)(#qN/) ]] || return
  typeset -g p10k_jj_conflicts_stale=1 p10k_jj_conflicts_updated=
  p10k segment -f grey -c '$p10k_jj_conflicts_stale' -e -t '$p10k_jj_conflicts'
  p10k segment -f 9 -c '$p10k_jj_conflicts' -e -t '$p10k_jj_conflicts'
  async_job jj_conflicts_worker jj_conflicts $PWD
}
