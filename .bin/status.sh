#!/bin/bash
function drawbar {
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
}

function status_disk {
    lsblk -nfl -o MOUNTPOINTS,FSAVAIL | awk 'NF && !/[SWAP]/ {print "["$1 " "$2"]"}' | tr "\n" " "
}

function status_cpu {
    cpu="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat)
    sleep 0.6
    eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat)
    intervaltotal=$((total-${prevtotal:-0}))
    echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")"
    printf "CPU: %02d%%" $cpu
}

function status_bat {
    BAT="BAT0"
    STAT=$(cat /sys/class/power_supply/$BAT/status)
    CNOW=$(cat /sys/class/power_supply/$BAT/energy_now)
    CFULL=$(cat /sys/class/power_supply/$BAT/energy_full)
    PERC=$((CNOW*100/CFULL))
    echo -en "$BAT:$(drawbar $PERC 4)$PERC%"
}

function status_mem {
    MEMF=$(cat /proc/meminfo | grep -i MemFree | awk '{print $2}')
    MEMT=$(cat /proc/meminfo | grep -i MemTotal | awk '{print $2}')
    MEM=$(($MEMF*100/$MEMT))
    echo -en "MEM:$(drawbar $MEM 5)$MEM%"
}

function status_date {
    echo -en "`date +\"%-d-%-m-%-y %H:%M\"`"
}

function tray {
    DBSTATUS=`dropbox-cli status`
    db_icon="\uE147"
    if [ "$DBSTATUS" = "Up to date" ]; then
        echo -en "$db_icon"
    elif [ "$DBSTATUS" = "Connecting..." ]; then
        echo -en "?"
    elif [ "$DBSTATUS" = "Dropbox isn't running!" ]; then
        echo -en "!"
    else
        echo -en "?"
    fi

    s_icon="\uE04D"
    if pidof spotify > /dev/null; then
        echo -en " $s_icon"
    else
        echo -en ""
    fi
}


D=$(echo -n '|')
STAT=" $(status_disk) $D $(status_bat) $D $(status_mem) $D $(status_cpu) $D $(status_date)"
echo -e $STAT
