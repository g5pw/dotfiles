# load highlighting
[ -d $ZDOTDIR/zsh-syntax-highlighting/ ] || return 255

source $ZDOTDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
