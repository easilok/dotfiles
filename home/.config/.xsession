#source /home/luis/.guix-extra-profiles/my-package/my-package/etc/profile
. ~/.profile

# Start Shepherd to manage user daemons
if [ -z "$(pgrep -u luis shepherd)" ]; then
  touch ~/started.pid
  shepherd
fi

#xterm
#exec /home/luis/.emacs.d/exwm/start-exwm.sh
bash ~/git/dwm/dwm_autorun.sh
exec dbus-launch dwm
