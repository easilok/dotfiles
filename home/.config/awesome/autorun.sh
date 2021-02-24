#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}


run lxsession
run compton
run picom
run nm-applet
run parcellite
betterlockscreen -w dim
xmodmap -e "clear lock" &
xmodmap -e "keycode 66 = Escape NoSymbol Escape" &
setxkbmap -option caps:escape &
setxkbmap -layout pt &
run nitrogen --restore
