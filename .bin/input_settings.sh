#!/bin/bash
setxkbmap pl
xmodmap /home/wbie/.Xmodmap
xset r rate 400 50
xinput set-prop 23 "libinput Accel Speed" -0.5
