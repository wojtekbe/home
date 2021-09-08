#!/bin/bash
BAT="BAT0"

STAT=$(cat /sys/class/power_supply/$BAT/status)
CNOW=$(cat /sys/class/power_supply/$BAT/energy_now)
CFULL=$(cat /sys/class/power_supply/$BAT/energy_full)
PERC=$((CNOW*100/CFULL))

echo -en "$BAT:$(drawbar.sh $PERC 4)$PERC%"
