#!/bin/bash

#mine
#$updates = $(checkupdates | wc -l)

# TODO - Check if programs exist before question

#imported
if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
# if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
# if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
# if ! updates_aur=$(pikaur -Qua 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    echo " %{u#ff9900}%{+u}%{F#ff9900}  %{F-}$updates "
else
    echo ""
fi

# sleep 900
