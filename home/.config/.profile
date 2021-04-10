#!/usr/bin/env sh
# Profile file. Runs on login.

export PATH="$PATH:$HOME/scripts/:$HOME/.local/bin:$HOME/.local/share/flatpak/exports/bin:$HOME/.nix-profile/bin"
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
	if [ -d "$profile"/share/man ]; then
        export MANPATH=$GUIX_PROFILE/share/man${MANPATH:+:}$MANPATH
    fi
	unset profile
    done
fi

## Default Guix
export GUIX_PROFILE="$HOME/.guix-profile"
[ -d "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"

[ -f "$HOME/.config/local_profile" ] && source "$HOME/.config/local_profile"
export XDG_DATA_DIRS=$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share/

# [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh
export NIX_PATH="nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs"
# these are fixes for discord. somehow it's missing libdrm, opt/Discord and something in mesa
# make sure you run nix-env -i mesa libdrm
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(nix-store -qR $(which drmdevice)  | grep drm | grep -v bin)/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.nix-profile/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.nix-profile/opt/Discord

export $(dbus-launch)

# setxkbmap pt &> /dev/null

