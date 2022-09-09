#!/bin/sh
(sleep 10 && dunst) &
(sleep 10 && redshift -l 52.23:21.01) &
(sleep 10 && unclutter -idle 5 -noevents) &
(sleep 10 && dropbox-cli start) &
#(sleep 10 && udiskie -2) &

setxkbmap pl
setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option "caps:escape"
xmodmap ~/.Xmodmap
xset r rate 400 50&

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

#USB Lenovo Keyboard/Trackpoint
xinput set-prop "pointer:Lenovo ThinkPad Compact USB Keyboard with TrackPoint" "libinput Accel Speed" -0.2
#Kensington Trackball
xinput set-prop "Primax Kensington Eagle Trackball" "libinput Middle Emulation Enabled" 1

#device specific stuff
case "$(hostname)" in
lotopalanka)
	WM="dwm"
	;;
5th)
	WM="dwm"
	#whole touchpad as scroll
	xinput --set-prop "AlpsPS/2 ALPS DualPoint TouchPad" 'Synaptics Edge Scrolling' 1 1 0
	xinput --set-prop "AlpsPS/2 ALPS DualPoint TouchPad" 'Synaptics Edges' 0 0 0 4282
	xinput --set-prop "AlpsPS/2 ALPS DualPoint TouchPad" 'Synaptics Scrolling Distance' 40 40
	;;
borsuk)
	WM="dwm"
	#trackpoint speed
	xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -0.5
	;;
szynszyla) #X1 Carbon 6th Gen
    WM="dwm"
    xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.9
    xinput disable "Synaptics TM3288-011"
    bash ~/.bin/szynszyla_screen_layout.sh
	nitrogen --restore
    ;;
esac

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
