#!/usr/bin/env bash

source_location=$HOME/git/xwayland-satellite
if [[ ! -d $source_location ]]
then
    echo "Xwayland-satellite source not found on $source_location. Please clone and build it before installing."
    exit 1
fi

cd $source_location

## Clean existing files before installing new ones
sudo rm /usr/local/bin/xwayland-satellite

## Install new xwayland-satellite build on system
sudo cp target/release/xwayland-satellite /usr/local/bin/
