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
# For example, a nice left-pointing arrow head cursor
xsetroot -cursor_name left_ptr &
xss-lock -- betterlockscreen -l dim &
wmname compiz
xmodmap ~/.Xmodmap

run lxsession
run picom
run nm-applet
run nitrogen --restore
run parcellite
# run snixembed
run stalonetray
# run trayer_dock
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
# eval `ssh-agent`

