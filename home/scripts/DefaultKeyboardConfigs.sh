#!/bin/bash

xmodmap -e "clear lock"
xmodmap -e "keycode 66 = Escape NoSymbol Escape"
setxkbmap -option caps:escape
setxkbmap -layout pt

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

xcape -e 'Control_L=Escape' -t 175

