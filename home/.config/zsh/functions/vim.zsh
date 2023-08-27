function v {
    if [ -f $(which nvim) ]; then 
        compdef v=nvim
        if [[ $# -gt 0 ]]; then
            nvim "$@"
        else
            nvim +GoToFile
        fi
    else
        compdef v=vim
        if [[ $# -gt 0 ]]; then
            vim "$@"
        else
            vim .
        fi
    fi
}
