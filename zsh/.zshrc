if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f ${ZDOTDIR:-$HOME}/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "${ZDOTDIR:-$HOME}/.zinit" && command chmod g-rwX "${ZDOTDIR:-$HOME}/.zinit"
    command git clone https://github.com/zdharma/zinit "${ZDOTDIR:-$HOME}/.zinit/bin" && \\
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \\
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

declare -A ZINIT
ZINIT[BIN_DIR]="$ZDOTDIR/zinit/bin"
ZINIT[HOME_DIR]="$ZDOTDIR/zinit"
source $ZDOTDIR/zinit/bin/zinit.zsh

module_path+=( "$ZDOTDIR/zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node


zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

prompt_my_docker_context () {
    local docker_context=$(docker context show)
    if [ "$docker_context" != "default" ]; then
	p10k segment -i '' -f blue -t "$docker_context"
    fi
}
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=my_docker_context

# Include files from zsh.d directory
for file in $ZDOTDIR/zsh.d/*.zsh; do
    source $file
done

# Useful commands
function rand() { exec $RANDOM % $1; }

# Useful command similar to xargs
autoload -U zargs

zinit ice as'command' lucid wait'1'
zinit snippet https://github.com/thanks4opensource/buck50/raw/master/build/buck50.py

source ~/.config/broot/launcher/bash/br
