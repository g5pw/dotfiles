# by default, we want this to get set.
# Even for non-interactive, non-login shells.
if [ "`id -gn`" = "`id -un`" -a `id -u` -gt 99 ]; then
        umask 002
  else
        umask 022
fi

## The maximum number of events stored in the internal history list.
export HISTSIZE=10000

## The maximum number of history events to save in the history file.
export SAVEHIST=9500

if (( ! EUID )); then
    HISTFILE=$ZDOTDIR/zsh_history_root
else
    HISTFILE=$ZDOTDIR/zsh_history
fi
export HISTFILE

## maximum size of the directory stack.
export DIRSTACKSIZE=20

## If nonnegative, commands whose combined user and system execution times
## (measured in seconds) are greater than this value have timing
## statistics printed for them.
export REPORTTIME=10

## use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 8k
limit -s

# This are characters that separates words
export WORDCHARS='*?-[]~=/&;!#$%^(){}<>'

# set go PATH
export GOPATH="$HOME/.go"

# Important dirs
hash -d Projects=$HOME/Documents/Projects
hash -d Uni=$HOME/Documents/University
hash -d MP_main=/opt/local/var/macports/sources/svn.macports.org/dports
hash -d MP_personal=/opt/local/var/macports/sources/mp-g5pw/dports

#load my function and more completions
fpath=($ZDOTDIR/functions $ZDOTDIR/zsh-completions/src $fpath)

# Use GNU utils if possible
if [[ -d /opt/local/libexec/gnubin ]]; then
    path=(/opt/local/libexec/gnubin $path)
fi
# Use perl utils if possible
if [[ -d /opt/local/libexec/perl5.12 ]]; then
    path=(/opt/local/libexec/perl5.12 $path)
fi

# Use ruby19 programs if possible
if [[ -d /opt/local/libexec/ruby1.9 ]]; then
    path=(/opt/local/libexec/ruby1.9 $path)
fi
