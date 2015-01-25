if [[ -o interactive ]]; then
    cows=($(cowsay -l | grep -v :))
    cowsay -f ${(q)cows[$(($RANDOM % ${#cows} + 1))]} "$(fortune -os)"
    unset cows
fi
