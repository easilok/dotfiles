#!/usr/bin/env bash

niri_location=$HOME/git/niri
if [[ ! -d $niri_location ]]
then
    echo "Niri source not found on $niri_location. Please clone and build it before installing."
    exit 1
fi

cd $niri_location

## Ensure requiring directories exist in file system
sudo mkdir -p /usr/local/share/wayland-sessions/
sudo mkdir -p /usr/local/share/xdg-desktop-portal/

## Clean existing files before installing new ones
sudo rm /usr/local/bin/niri
sudo rm /usr/local/bin/niri-session
sudo rm /usr/local/share/wayland-sessions/niri.desktop
sudo rm /usr/local/share/xdg-desktop-portal/niri-portals.conf
sudo rm /etc/systemd/user/niri.service
sudo rm /etc/systemd/user/niri-shutdown.target

## Install new niri build on system
sudo cp target/release/niri /usr/local/bin/
sudo cp resources/niri-session /usr/local/bin/
sudo cp resources/niri.desktop /usr/local/share/wayland-sessions/niri.desktop
sudo cp resources/niri-portals.conf /usr/local/share/xdg-desktop-portal/
sudo cp resources/niri.service /etc/systemd/user/
sudo cp resources/niri-shutdown.target /etc/systemd/user/
