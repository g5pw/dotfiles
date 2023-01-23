function () {
    if [[ -o interactive ]]; then
        local cows=($(cowsay -l | grep -v :))
        fortune -as | cowsay -nf ${(q)cows[$(($RANDOM % ${#cows} + 1))]}
    fi
}
