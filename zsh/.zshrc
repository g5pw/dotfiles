# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -d $ZDOTDIR/.zinit/bin ]]; then
  printf "zinit not found. install? [Y/n] "
  if read -q response; then
    curl -L https://github.com/zdharma/zinit/raw/master/doc/install.sh | sh
    source $ZDOTDIR/.zinit/bin/zinit.zsh
    zinit module build
  else
    return
  fi
fi

source $ZDOTDIR/.zinit/bin/zinit.zsh

module_path+=( "$ZDOTDIR/.zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin

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


source ~/.config/broot/launcher/bash/br
