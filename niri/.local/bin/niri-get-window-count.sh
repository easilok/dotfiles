#!/usr/bin/env bash


while :
do

    WORKSPACE_ID=$(niri msg focused-window | grep -i workspace | awk '{print $3}' 2> /tmp/niri-cmd.log)

    [ -z $WORKSPACE_ID ] && exit 1

    WORKSPACE_WINDOWS_COUNT=$(niri msg windows | grep -i "workspace id: $WORKSPACE_ID" | wc -l 2> /tmp/niri-cmd.log)

    [ -z $WORKSPACE_WINDOWS_COUNT ] && exit 1

    echo "{\"text\": $WORKSPACE_WINDOWS_COUNT}"

    sleep 5
done
