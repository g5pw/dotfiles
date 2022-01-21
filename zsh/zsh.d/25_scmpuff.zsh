zinit ice from"gh-r" as"program" \
	atload'eval "$(scmpuff init -s -a=false)"' \
	bpick"scmpuff_*linux_x64*" \
	ver'v0.4.0'
zinit light mroth/scmpuff

alias gs="scmpuff_status"
