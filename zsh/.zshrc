source $ZDOTDIR/zplugin/zplugin.zsh

module_path+=( "$ZDOTDIR/zplugin/zmodules/Src" )
zmodload zdharma/zplugin

# Include files from zsh.d directory
for file in $ZDOTDIR/zsh.d/*.zsh; do
    source $file
done

# Useful commands
function rand() { exec $RANDOM % $1; }

# Useful command similar to xargs
autoload -U zargs

[ -r $HOME/.iterm2_shell_integration.zsh ] && source $HOME/.iterm2_shell_integration.zsh
if [[ $TERM == xterm-termite ]]; then
    source /etc/profile.d/vte-2.91.sh
    __vte_osc7
fi
