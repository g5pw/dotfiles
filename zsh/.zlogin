if [[ -z $SILENT || $SHLVL -lt 2 ]]; then
    cowsay -f "$(ls /opt/local/share/cowsay/cows/*.cow | unsort 2>/dev/null | head -1)" "$(fortune -s)"
fi
