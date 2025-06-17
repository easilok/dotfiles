#!/usr/bin/env bash
if [ $(pgrep -f "xfce4-session") ]; then
  xflock4 
elif [ -f "$(which i3lock-clock-image)" ]; then 
    i3lock-clock-image
elif [ -f "$(which i3lock-clock)" ]; then 
    i3lock-clock
elif [ -f "$(which i3lock-fancy)" ]; then 
   i3lock-fancy -p -- scrot
 else
   i3lock
fi
