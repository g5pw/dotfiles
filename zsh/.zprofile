# Include user profile
if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi

#custom exports for coloured less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# enable extended glob
setopt extended_glob
#
# Use GNU utils if possible
if [[ -d /opt/local/libexec/gnubin ]]; then
    path=(/opt/local/libexec/gnubin $path)
fi
# Use perl utils if possible
if [[ -d /opt/local/libexec/perl5.12 ]]; then
    path=(/opt/local/libexec/perl5.12 $path)
fi
