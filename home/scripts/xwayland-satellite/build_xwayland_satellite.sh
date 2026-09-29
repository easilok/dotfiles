#!/usr/bin/env bash

source_location=$HOME/git/xwayland-satellite
source_repo="https://github.com/Supreeeme/xwayland-satellite.git"
source_tag="main"

dependencies_required_feedback() {
    echo "Install dependencies for building Xwayland-satellite"
    echo "  Follow the documentation on $source_repo"
    echo "  sudo apt-get install -y clang xwaland xcb xcb-util-cursor"
    exit 1
}
read -p "Are you sure you have all dependencies installed to build Xwayland-satellite?" choice
case "$choice" in 
  y|Y ) echo "All dependencies are confirmed.";;
  * ) dependencies_required_feedback;;
esac

if [ ! -f "$(which cargo)" ]; then
    echo "Cargo is not installed but is required to build Xwayland-satellite"
    exit 1
fi

if [[ -d $source_location ]]
then
    cd $source_location
else
    echo "Cloning Xwayland-satellite source from $source_repo to $source_location"
    git clone "$source_repo" "$source_location"
    cd $source_location
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
