if [[ -o interactive ]]; then
    cows=($(cowsay -l | grep -v :))
    cowsay -f ${(q)cows[$(($RANDOM % ${#cows}))]} "$(fortune -a)"
    unset cows
fi
