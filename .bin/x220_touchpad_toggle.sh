#!/bin/sh
ST=$(xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Enabled" | awk -F ':' '{print $2}')
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" $(( 1 ^ $ST ))
