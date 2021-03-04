#!/usr/bin/env sh
# Profile file. Runs on login.

export PATH="$PATH:$HOME/scripts/:$HOME/.local/bin:$HOME/.local/share/flatpak/exports/bin"
export EDITOR="vim"
export TERMINAL="termite"
# export TERMINAL="kitty"
export BROWSER="qutebrowser"
export READER="zathura"
export FILE="vifm"
export VIDEO="mpv"
export MUSIC="ncmpcpp"
# export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
export WM="xmonad"
export _JAVA_AWT_WM_NONREPARENTING=1

# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel
# source virtualenvwrapper.sh

# [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server if i3 not already running.
# [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x $WM >/dev/null && exec startx

# Switch escape and caps if tty:
# sudo -n loadkeys ~/.local/bin/ttymaps.kmap 2>/dev/null

export PATH="$HOME/.cargo/bin:$HOME/.emacs.d/bin:$PATH"

## Extra Guix profiles section
unset GUIX_PROFILE
GUIX_EXTRA_PROFILES="$HOME/.guix-extra-profiles"
if [ -d "$GUIX_EXTRA_PROFILES" ]; then
    for i in $GUIX_EXTRA_PROFILES/*; do
	profile=$i/$(basename "$i")
	if [ -f "$profile"/etc/profile ]; then
	    GUIX_PROFILE="$profile"
	    . "$GUIX_PROFILE"/etc/profile
	fi
	unset profile
    done
fi

## Default Guix
export GUIX_PROFILE="$HOME/.guix-profile"
[ -d "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"

[ -f "$HOME/.config/local_profile" ] && source "$HOME/.config/local_profile"
export XDG_DATA_DIRS=$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share/


setxkbmap pt &> /dev/null

