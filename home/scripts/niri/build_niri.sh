#!/usr/bin/env bash

niri_location=$HOME/git/niri
niri_repo="git@github.com:niri-wm/niri.git"
source_tag="main"

dependencies_required_feedback() {
    echo "Install dependencies for building niri"
    echo "  Follow the documentation on https://niri-wm.github.io/niri/Getting-Started.html#manual-installation"
    echo "  sudo apt-get install -y gcc clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev"
    exit 1
}
read -p "Are you sure you have all dependencies installed to build niri?" choice
case "$choice" in 
  y|Y ) echo "All dependencies are confirmed.";;
  * ) dependencies_required_feedback;;
esac

if [ ! -f "$(which cargo)" ]; then
    echo "Cargo is not installed but is required to build niri"
    exit 1
fi

if [[ -d $niri_location ]]
then
    cd $niri_location
else
    echo "Cloning nire source from $niri_repo to $niri_location"
    git clone "$niri_repo" "$niri_location"
    cd $niri_location
    echo [Done.]
fi

echo "Refreshing sources from upstream..."
echo "Checking out $source_tag ..."

sleep 2
git fetch --all && git pull --all &&
git checkout $source_tag &&

echo "[ Done. ]"

sleep 2

cargo build --release
