#!/bin/sh
# Run the screen compositor
picom &

wmname compiz

# Enable screen locking on suspend
# xss-lock -- slock &
# xss-lock -- betterlockscreen -l dim &

# Fire it up
exec dbus-launch --exit-with-session emacs -mm --debug-init -l ~/.emacs.d/desktop.el
