#!/usr/bin/env sh

export EDITOR="vim"
export TERMINAL="kitty"
# export TERMINAL="kitty"
# export BROWSER="qutebrowser"
# export BROWSER="brave-browser"
export BROWSER="firefox"
export READER="zathura"
export FILE="lf"
export VIDEO="mpv"
export MUSIC="ncmpcpp"
# export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
export WM="xmonad"
export _JAVA_AWT_WM_NONREPARENTING=1
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set user scripts folder
if [ -d "$HOME/scripts" ]; then
    PATH="$HOME/scripts:$PATH"
fi

if [ -d "$HOME/go/bin" ]; then
   PATH=$HOME/go/bin:$PATH
fi

