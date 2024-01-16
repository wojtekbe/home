#!/bin/bash
case "$(hostname)" in
5th) # Dell D430
	#whole touchpad as scroll
	xinput --set-prop "AlpsPS/2 ALPS DualPoint TouchPad" 'Synaptics Edge Scrolling' 1 1 0
	xinput --set-prop "AlpsPS/2 ALPS DualPoint TouchPad" 'Synaptics Edges' 0 0 0 4282
	xinput --set-prop "AlpsPS/2 ALPS DualPoint TouchPad" 'Synaptics Scrolling Distance' 40 40
	;;
borsuk) # Thinkpad X220
	#trackpoint speed
	xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -0.5
	;;
szynszyla) #X1 Carbon 6th Gen
    # reconnet touchpad/trackpoint after sleep
    echo -n "none" | sudo tee /sys/bus/serio/devices/serio1/drvctl > /dev/null
    echo -n "reconnect" | sudo tee /sys/bus/serio/devices/serio1/drvctl > /dev/null
    xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.9
    xinput disable "Synaptics TM3288-011"
    ;;
esac

#Kensington Trackball
xinput set-prop "Primax Kensington Eagle Trackball" "libinput Middle Emulation Enabled" 1

# language settings
setxkbmap pl
setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option "caps:escape"
xmodmap /home/wbie/.Xmodmap

# keyboard rate
xset r rate 400 50
