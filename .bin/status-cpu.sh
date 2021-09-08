#!/bin/bash

cpu="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat)
  sleep 0.6
  eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat)
  intervaltotal=$((total-${prevtotal:-0}))
  echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")"
printf "cpu: %02d%%" $cpu
