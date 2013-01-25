# by default, we want this to get set.
# Even for non-interactive, non-login shells.
if [ "`id -gn`" = "`id -un`" -a `id -u` -gt 99 ]; then
        umask 002
  else
        umask 022
fi

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

#custom exports for coloured less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# This are characters that separates words
export WORDCHARS='*?-[]~=/&;!#$%^(){}<>'

# Important dirs
export Projects=$HOME/Documents/Projects
export Uni=$HOME/Documents/University
export MP_main=/opt/local/var/macports/sources/svn.macports.org/dports
export MP_personal=/opt/local/var/macports/sources/mp-g5pw/dports

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
