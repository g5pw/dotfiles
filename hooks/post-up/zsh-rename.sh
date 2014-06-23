#!/bin/sh

for f in $(find ~/.zsh/ -maxdepth 1 -type l -not \( -name 'zsh-*' -or -name '.*' \)); do
    name=`basename $f`
    dir=`dirname $f`
    mv $f $dir/.$name
done
