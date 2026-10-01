#!/usr/bin/env bash


WORKSPACE_ID=$(niri msg focused-window | grep -i workspace | awk '{print $3}')

[ -z $WORKSPACE_ID ] && exit 1

WORKSPACE_WINDOWS_COUNT=$(niri msg windows | grep -i "workspace id: $WORKSPACE_ID" | wc -l)

[ -z $WORKSPACE_WINDOWS_COUNT ] && exit 1

echo $WORKSPACE_WINDOWS_COUNT
