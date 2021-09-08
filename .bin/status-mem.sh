#!/bin/bash

MEMF=$(cat /proc/meminfo | grep -i MemFree | awk '{print $2}')
MEMT=$(cat /proc/meminfo | grep -i MemTotal | awk '{print $2}')
MEM=$(($MEMF*100/$MEMT))
echo -en "mem:$(drawbar.sh $MEM 5)$MEM%"
