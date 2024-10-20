#!/usr/bin/env bash

[[ -z $(which stow) ]] && echo "stow not found" && exit 1

stowFolders=(
    "bookmarks"
    "i3"
    "nvim"
    "taskwarrior"
    "wezterm"
)


for folder in ${stowFolders[@]}; do
    echo "stowing $folder"
    stow --target=$HOME --simulate $folder
done
