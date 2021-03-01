#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

numlockx &
xmodmap -e "clear lock" &
xmodmap -e "keycode 66 = Escape NoSymbol Escape" &
setxkbmap -option caps:escape &
setxkbmap -layout pt &
# load xmodmap file
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
# set desktop background with custom effect
# betterlockscreen -w dim

# if [ "$WM" = "xmonad" ] ; then $HOME/.xmonad/autorun.sh ; fi
# if [ "$WM" = "dwm" ] ; then 
# 	killall dwm_autorun 
# 	dwm_autorun
# fi

if [ "$WM" = "i3" ] ; then
	exec i3
elif [ "$WM" = "awesome" ] ; then
	exec awesome
elif [ "$WM" = "xmonad" ] ; then
	# $HOME/.xmonad/autorun.sh
    # For java applications to work properly
    wmname compiz
	exec xmonad
elif [ "$WM" = "qtile" ] ; then
	exec qtile
elif [ "$WM" = "dwm" ] ; then
	killall dwm_autorun.sh
	dmw_autorun.sh
	exec dwm
elif [ "$WM" = "openbox" ] ; then
	exec openbox-session
elif [ "$WM" = "cinnamon" ] ; then
	exec cinnamon-session
elif [ "$WM" = "exwm" ] ; then
    exec /home/luis/.emacs.d/exwm/start-exwm.sh
else
	exec awesome
fi
