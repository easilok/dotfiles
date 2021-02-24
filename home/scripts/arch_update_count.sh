#!/bin/bash

#mine
#$updates = $(checkupdates | wc -l)

if command -v pacman >/dev/null 2>/dev/null; then

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
			echo $updates
	else
			echo 0
	fi

elif command -v apt >/dev/null 2>/dev/null; then

	updates=$(apt list --upgradable 2>/dev/null | wc -l)

	if [ "$updates" -gt 0 ]; then
			echo $updates
	else
			echo 0
	fi

else

	echo 0

fi

# sleep 900
