#!/usr/bin/env bash

[[ -z $(which stow) ]] && echo "stow not found" && exit 1
[[ -z $HOSTNAME ]] && echo "HOSTNAME environment is required for deploying" && exit 1

baseFolders=(
    "nvim"
    "taskwarrior"
    "starship"
)

desktopFolders=(
    "bookmarks"
    "awesomewm"
    "picom"
    "i3"
    "i3lock"
    "wezterm"
    "greenclip"
)

extraFolders=(
    "profile"
)

# stowFolders+=( 
#     "${desktopFolders[@]}"
#     "${baseFolders[@]}"
#     "${extraFolders[@]}"
# )

case $HOSTNAME in
  "ackerman")
      stowFolders=(
          "awesomewm"
          "picom"
          "nvim"
          "taskwarrior"
      )
    ;;

  "cloud-nix")
      stowFolders=(
          "nvim"
          "taskwarrior"
      )
    ;;
  *)
      echo "Hostname \"$HOSTNAME\" not recognized"
      exit 1
    ;;
esac


for folder in ${stowFolders[@]}; do
    echo "stowing $folder"
    stow --target=$HOME --simulate $folder
done
