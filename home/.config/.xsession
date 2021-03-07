#source /home/luis/.guix-extra-profiles/my-package/my-package/etc/profile
. ~/.profile
#xterm
#exec /home/luis/.emacs.d/exwm/start-exwm.sh
bash ~/git/dwm/dwm_autorun.sh
exec dwm
