#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

sleep 5
xmodmap -e "clear lock" &
xmodmap -e "keycode 66 = Escape NoSymbol Escape" &
setxkbmap -option caps:escape &
setxkbmap -layout pt &
# For example, a nice left-pointing arrow head cursor
# Directly on qtile
# xsetroot -cursor_name left_ptr &

run lxsession
run compton
run nm-applet
run nitrogen --restore
run parcellite
