# Include user profile
if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi

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
