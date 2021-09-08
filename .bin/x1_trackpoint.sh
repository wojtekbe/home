#!/bin/bash
echo -n "none" | sudo tee /sys/bus/serio/devices/serio1/drvctl > /dev/null
echo -n "reconnect" | sudo tee /sys/bus/serio/devices/serio1/drvctl > /dev/null
sleep .5
xinput disable "Synaptics TM3288-011"
xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 1.0
