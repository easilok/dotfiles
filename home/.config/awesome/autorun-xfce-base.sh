#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

sleep 5
numlockx &
xmodmap -e "clear lock" &
xmodmap -e "keycode 66 = Escape NoSymbol Escape" &
setxkbmap -option caps:escape &
setxkbmap -layout pt &
# xsetroot -cursor_name left_ptr &
xss-lock -- i3lock &
wmname compiz

if [ -f "$(which i3lock-fancy)" ]; then 
  xss-lock -- i3lock-fancy &
else
  xss-lock -- i3lock &
fi
# xscreensaver -no-splash &

# Commented out as something in the config is locking the WM
run nm-applet
# run nitrogen --restore
run ~/scripts/set_wallpaper
run parcellite
# run clipmenud
# run xfce4-clipman
# run dunst # awesome has own notify system
run xsettingsd
run sxhkd
run nextcloud
# If there's a personal Xmodmap setup, use it
[[ -f "$HOME/.Xmodmap" ]] && xmodmap ~/.Xmodmap

# XDG
run /usr/libexec/at-spi-bus-launcher --launch-immediately
run blueman-applet
# light-locker
run mintupdate-launcher
run mintreport-tray
run /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1
run start-pulseaudio-x11
# run xfce4-power-manager
# run xfce4-volumed
run warpinator --autostart
# run /usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd
run system-config-printer-applet
run /usr/bin/gnome-keyring-daemon --start --components=ssh
# run /usr/bin/gnome-keyring-daemon --start

run picom

run ssh-agent -D -a /run/user/1000/ssh-agent.socket
