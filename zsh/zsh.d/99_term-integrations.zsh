# Termite
if [[ $TERM == xterm-termite ]]; then
    source /etc/profile.d/vte-2.91.sh
    __vte_osc7
fi

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Kitty
which kitty &>/dev/null && kitty + complete setup zsh | source /dev/stdin

vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
