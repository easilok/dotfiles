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
xsetroot -cursor_name left_ptr &
xss-lock -- i3lock &
# xscreensaver -no-splash &
wmname compiz

# run lxsession
run lxpolkit
run picom
run nm-applet
# run nitrogen --restore
run ~/scripts/set_wallpaper
# run parcellite
# run clipmenud
run xfce4-clipman
# run dunst # awesome has own notify system
run xsettingsd
run sxhkd
run nextcloud
xmodmap ~/.Xmodmap
