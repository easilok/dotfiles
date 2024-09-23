#!/usr/bin/env bash
if [ $(pgrep -f "xfce4-session") ]; then
  xflock4 
elif [ -f "$(which i3lock-fancy)" ]; then 
   i3lock-fancy -p -- scrot
 else
   i3lock
fi
