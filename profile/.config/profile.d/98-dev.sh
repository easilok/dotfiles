#!/usr/bin/env sh

export TMUX_SESSIONIZER_PATH="$HOME/projects/playground/syncthing/go $HOME/projects/playground/rust $HOME/projects/playground/go $HOME/projects/playground/node $HOME/projects/playground/syncthing/vue $HOME/projects/playground/*"

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# export NVM_DIR="$HOME/.config/nvm"
# if [ -d $NVM_DIR ]; then
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# fi

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
