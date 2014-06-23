if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi

# Append to PATH
append () {
  # First remove the directory
  local IFS=':'
  local NEWPATH
  for DIR in $PATH; do
     if [ "$DIR" != "$1" ]; then
       NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
     fi
  done

  # Then append the directory
  export PATH=$NEWPATH:$1
}

# Prepend to PATH
prepend () {
  # First remove the directory
  local IFS=':'
  local NEWPATH
  for DIR in $PATH; do
     if [ "$DIR" != "$1" ]; then
       NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
     fi
  done

  # Then prepend the directory
  export PATH=$1:$NEWPATH
}

# MPLAB compilers
append /Applications/microchip/PICC-pro/bin

#PicKit 2 Device file
append /usr/share/pk2

# Imperative that this environment variable always reflects the output
# of the tty command.
GPG_TTY=`tty`
export GPG_TTY

# Cleanup
unset append prepend

# Source the .bashrc
if [ -f "$HOME/.bashrc" ] ; then
  . $HOME/.bashrc
fi
