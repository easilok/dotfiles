#!/usr/bin/env bash

echo $(bspc query -N -d focused -n .window.\!hidden | wc -l)
