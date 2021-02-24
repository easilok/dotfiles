#!/usr/bin/env sh
# Syncs repositories and downloads updates, meant to be run as a cronjob.

PW=$(cat $HOME/.config/userPass)

# check lock
if [ -f /var/lib/pacman/db.lck ]; then exit; fi

ping -q -c 1 1.1.1.1 > /dev/null || exit

notify-send "📦 Repository Sync" "Checking for package updates..."

echo $PW | sudo -S pacman -Syuw --noconfirm || notify-send "Error downloading updates.
Check your internet connection, if pacman is already running, or run update manually to see errors."
#pkill -RTMIN+8 "${STATUSBAR:?}"

if pacman -Qu | grep -v "\[ignored\]"
then
	notify-send "🎁 Repository Sync" "Updates available. Click statusbar icon (📦) for update."
else
	notify-send "📦 Repository Sync"  "Sync complete. No new packages for update."
fi
