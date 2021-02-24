#!/bin/bash


firefox_color1="#F62336"
firefox_color2="#FF6611"
firefox_color3="#FFEC4A"
status_style="#prompt { background-color: $firefox_color2; }"
# special="-a 0 -selected-row 1"
special=""
status="  "

query=$(rofi -theme themes/websearchmenu.rasi -theme-str "$status_style" -p "$status" -dmenu -i $special)

query="${query// /+}"
query="${query//[^A-Za-z0-9\"-]/}"

if [ ! -z "$query" ]; then
  firefox -new-tab www.google.com/search?q=$query &
  # echo $query
fi

exit
