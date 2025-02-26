#!/usr/bin/env sh
#
# # [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh
# export NIX_PATH="nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs"
# export PATH="$HOME/.nix-profile/bin:$PATH"
# # these are fixes for discord. somehow it's missing libdrm, opt/Discord and something in mesa
# # make sure you run nix-env -i mesa libdrm
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(nix-store -qR $(which drmdevice)  | grep drm | grep -v bin)/lib/
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.nix-profile/lib
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.nix-profile/opt/Discord


