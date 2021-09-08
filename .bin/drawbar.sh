#!/bin/bash

W=$2
B=$[100/$W]
N_INT=$[$1/$B]
N_TENS=$[$1%$B*10/$B]
BAR=""
for i in $(seq 1 $N_INT); do
	BAR="$BAR\ue1ca"
done
if [ $N_INT -ne $B ]; then
	BAR="$BAR\ue1c$N_TENS"
	for i in $(seq 1 $[$W-$N_INT-1]); do
		BAR="$BAR\ue1c0"
	done
fi
echo -en "\ue1cb$BAR\ue1cc"
