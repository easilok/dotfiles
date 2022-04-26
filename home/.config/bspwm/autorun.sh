#!/usr/bin/env bash
run() {
	if [ ! $(pgrep -f $1) ]
  then
    $@&
  fi
}

# if [ $(pgrep -f "dwm_autorun") ] ; then
# 	echo "Already Started"
# 	exit
# fi

sleep 5
numlockx &
xmodmap -e "clear lock" &
xmodmap -e "keycode 66 = Escape NoSymbol Escape" &
setxkbmap -option caps:escape &
setxkbmap -layout pt &
xsetroot -cursor_name left_ptr &
xss-lock -- i3lock &
wmname compiz

# run lxsession
run lxpolkit
# run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
run picom
run nm-applet
# run nitrogen --restore
run ~/scripts/set_wallpaper
# run parcellite
# run clipmenud
run xfce4-clipman
run dunst
run xsettingsd
~/.config/bspwm/scripts/bspwm_arrange_monitors &
# run sxhkd
~/.config/bspwm/scripts/launch_sxhkd.sh
xmodmap ~/.Xmodmap

~/.config/polybar/launch.sh &
