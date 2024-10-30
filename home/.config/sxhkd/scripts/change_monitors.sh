#!/usr/bin/env bash

[[ -z $WIFI_INTERFACE ]] &&  WIFI_INTERFACE=wlp0s20f3 
WIFI_SSID=$(nmcli -t -f name,device connection show --active | grep $WIFI_INTERFACE| cut -d\: -f1)

if [ "$WIFI_SSID" = "Gandhi Vladimir" ] || [ "$WIFI_SSID" = "House of Cats" ]; then
    echo "Connected to home network ($WIFI_SSID), using default home monitor setup."
    $HOME/.screenlayout/home_left_monitor
elif [[ "$WIFI_SSID" == "Addvolt"* ]]; then
    echo "Connected to Addvolt network ($WIFI_SSID), using default addvolt monitor setup."
    $HOME/.screenlayout/addvolt_top_monitor
else
    $HOME/.config/dmenu/scripts/dmenu-screen
fi
