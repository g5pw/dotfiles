if [[ -o interactive ]]; then
    cows=($(cowsay -l | grep -v :))
    fortune -as | cowsay -nf ${(q)cows[$(($RANDOM % ${#cows} + 1))]}
    unset cows
fi
