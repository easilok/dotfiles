#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

xmodmap -e "clear lock" &
xmodmap -e "keycode 66 = Escape NoSymbol Escape" &
setxkbmap -layout pt &
run compton
run nm-applet
run nitrogen --restore
run parcellite
run lxsession

