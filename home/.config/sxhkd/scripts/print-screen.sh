#!/usr/bin/env bash

if [ -f "$(which todo-txt)" ]; then 
    flameshot gui
else
    notify-send "No screenshot application is available for usage."
fi

