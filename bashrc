# Insert /ect/bashrc
if [ -f "/etc/bashrc" ] ; then
  . /etc/bashrc
fi

export CLICOLOR="YES"
export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"

# GPG stuff
export GPG_TTY=`tty`

#Tweak prompt
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
export PS2="\[\$(tput bold)\] ➣  \[\$(tput clear)\]"

#History configuration
export HISTCONTROL="ignoreboth"

# Useful commands
function box() { t="$1xxxx";c=${2:-=}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }
#   Alert function
function alert() { "$@"; st=$?; growlnotify -a iTerm -m "Command completed with exit code $st" -t "${@:1:1}"; return $st; }
function acronym() { elinks -no-numbering -dump http://acronymfinder.com/$1.html | sed '/*/!d'; }
function vcs(){
oldIFS=$IFS
IFS='/'
path=($PWD)
IFS=oldIFS
dir=''
for i in ${!path[*]}; do
    dir="$dir/${path[$i]}"
    if [ -d "$dir/.svn" ]; then
	svn "$@"
	return 0
    elif [ -d "$dir/.git" ]; then
	git "$@"
	return 0
    elif [ -d "$dir/.hg" ]; then
	hg "$@"
	return 0
    fi
done
echo 'No known repository found!'
return 127
}

function rand() { exec $RANDOM % $1; }
function sleeptime() {
    echo $1
    for i in {3..10}; do
	sleep=`expr $i '*' 90`
	date -j -v+${sleep}M
done
}

if [ -f "$HOME/.bash_aliases" ] ; then
  . $HOME/.bash_aliases
fi


[ -s "/Users/g5pw/.scm_breeze/scm_breeze.sh" ] && source "/Users/g5pw/.scm_breeze/scm_breeze.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source ~/.config/broot/launcher/bash/br
