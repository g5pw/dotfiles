if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

fortune -as | cowsay -nf $(cowsay -l | sed -e 1d -e 's/ /\n/g' | shuf -n1)
