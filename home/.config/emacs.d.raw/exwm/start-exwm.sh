#!/bin/sh 

. ~/.profile

xhost +SI:localuser:$USER

export _JAVA_AWT_WM_NONREPARENTING=1

# Run the screen compositor
picom &

#wmname compiz

lxsession &

# Enable screen locking on suspend
# xss-lock -- slock &
# xss-lock -- betterlockscreen -l dim &

xset -b
#xhost +

# Run clipboard manager
clipmenud &

# Fire it up
exec dbus-launch --exit-with-session emacs -mm --debug-init -l ~/.emacs.d/desktop.el
