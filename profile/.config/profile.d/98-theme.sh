#!/usr/bin/env sh

if [ -f "$HOME/.config/xsettingsd/xsettingsd.conf" ]; then
    # export GTK_THEME=$(grep '^Net/ThemeName' $HOME/.config/xsettingsd/xsettingsd.conf | awk '{ print $2}' | sed -e 's/-/:/g')
    export GTK_THEME='Arc:dark'
fi


