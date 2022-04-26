#!/usr/bin/env bash

CONFIG_FILE=~/.config/polybar/my_config.ini 

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar bspwm -c $CONFIG_FILE &

if [[ $(xrandr -q | grep 'DP1 connected') ]]; then
  polybar bspwm-dp1 -c $CONFIG_FILE
fi
