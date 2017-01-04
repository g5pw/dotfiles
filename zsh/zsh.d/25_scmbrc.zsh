# SCM-Breeze load
typeset -a scm_breeze_dirs=(~proj/scm_breeze
                            ~/.scm_breeze )

for dir in $scm_breeze_dirs; do
    if [[ -d $dir && -r  $dir/scm_breeze.sh ]]; then
        source $dir/scm_breeze.sh
        break
    fi
done

# Clean up
unset scm_breeze_dirs
