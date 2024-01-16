#!/bin/sh
(sleep 10 && dunst) &
(sleep 10 && redshift -l 52.23:21.01) &
(sleep 10 && unclutter -idle 5 -noevents) &
(sleep 10 && udiskie -2) &

xsetroot -cursor_name left_ptr& # set mouse pointer
xautolock -time 5 -locker slock& # lock screen after 5 mins
xset s off -dpms&
#xscreensaver -no-splash &

export XTERM=st
export XEDITOR=leafpad
export FM=thunar
export QT_QPA_PLATFORMTHEME=qt5ct
export _JAVA_AWT_WM_NONREPARENTING=1

# to set the default browser:
#BROWSER="" xdg-settings set default-url-scheme-handler http firefox.desktop
#BROWSER="" xdg-settings set default-url-scheme-handler https firefox.desktop
#BROWSER="" xdg-settings set default-web-browser forefox.desktop

~/.bin/input_cfg.sh

WM="dwm"

case $WM in
gnome)
	exec gnome-session
	;;
kde)
	exec startplasma-x11
	;;
openbox)
	xcompmgr -c -t0 -l0 -r2 -C &
	(sleep 5 && nitrogen --restore) &
	(sleep 5 && dzen-status) &
	exec  openbox-session
	;;
dwm)
	xcompmgr -c -t-5 -l-5 -r0 -C &
	nitrogen --restore &
	~/.bin/dwm-status &
	exec ~/.bin/startdwm
	;;
esac

