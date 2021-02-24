#!/bin/bash

BROWSER=surf

function openHTML {
  if [ -f "$1" ]; then
    mv $1 $1.html
    qutebrowser --target tab $1.html > /dev/null &
    # surf $1.html &> /dev/null &
    # case "$BROWSER" in
    #   "qutebrowser") qutebrowser --target window $1.html &> /dev/null &
    #   "surf") surf $1.html &> /dev/null &
    # esac
  fi
}


if [ "$#" -lt 2 ]; then
  exit
fi

case "$2" in
  "html") openHTML "$1"
esac
