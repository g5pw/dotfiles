if [[ -o interactive ]]; then
    cows=($(cowsay -l | grep -v :))
    fortune -os | cowsay -nf ${(q)cows[$(($RANDOM % ${#cows} + 1))]}
    unset cows
fi
