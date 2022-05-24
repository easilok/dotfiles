compdef g=git
function g {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status --short --branch
  fi
}

source $HOME/.config/zsh/functions/omzsh_git.zsh

