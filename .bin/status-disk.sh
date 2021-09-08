#!/bin/bash
lsblk -nfl -o MOUNTPOINTS,FSUSE% | awk 'NF && !/[SWAP]/ {print "["$1 " "$2"]"}' | tr "\n" " "
