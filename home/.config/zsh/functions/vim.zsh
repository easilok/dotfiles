function v {
    if [ -f $(which nvim) ]; then 
        compdef v=nvim
        if [[ $# -gt 0 ]]; then
            nvim "$@"
        else
            nvim +Startify +GoToFile
        fi
    else
        compdef v=vim
        vim "$@"
    fi
}
