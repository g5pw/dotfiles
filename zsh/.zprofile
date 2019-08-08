# Include user profile
if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi

# enable extended glob
setopt extended_glob
