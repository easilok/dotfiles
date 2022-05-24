#!/usr/bin/env bash
run() {
	if [ ! $(pgrep -f $1) ]
  then
    $@&
  fi
}

sleep 5
numlockx &
xmodmap -e "clear lock" &
xmodmap -e "keycode 66 = Escape NoSymbol Escape" &
setxkbmap -option caps:escape &

# wmname compiz

run picom

# run sxhkd
~/.config/bspwm/scripts/launch_sxhkd.sh

xmodmap ~/.Xmodmap

