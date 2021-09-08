#!/bin/bash

_red()
{
	echo -en "\x04$*\x01"
}

_gr()
{
	echo -en "\x05$*\x01"
}

_yel()
{
	echo -en "\x03$*\x01"
}

_bar()
{
	echo $1 | gdbar -h 6
}

D=$(echo -en "\x05|")

mail() {
	MAILS=""
	GMAILCOUNT=`~/.bin/gmail_bash.sh`
	if [ $GMAILCOUNT -ge 1 ]; then
		MAILS=" ^ca(1, firefox http://mail.google.com)^fg(red)^i(/usr/share/icons/stlarch_icons/mail4.xbm)^fg()  ^ca()"
	else
		MAILS=""
	fi
	echo -en $MAILS
}

mail2()
{
	icon="^i(/usr/share/icons/stlarch_icons/mail4.xbm)"
	MAILS=""
	MAILC=$(cat ~/mails)
	if [ $MAILC -ge 1 ]; then
		MAILS=" ^ca(1, firefox http://mail.google.com)^fg(red)$icon^fg()  ^ca()"
	else
		MAILS=""
	fi
	echo -n $MAILS
}

cpu(){
     cpu="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat)
          sleep 0.6
          eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat)
          intervaltotal=$((total-${prevtotal:-0}))
          echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")"
      if [ $cpu -le 9 ]; then printf "\x01%02d%%" $cpu
	  elif [ $cpu -ge 80 ]; then echo -en "$(_yel $(printf "%02d" $cpu)%)"
	  elif [ $cpu -ge 90 ]; then echo -en "$(_red $(printf "%02d" $cpu)%)"
      else printf "\x01%02d%%" $cpu
      fi
}

cputemp() {
	TEMP=`sensors | grep temp1 | awk '{print $2}' | sed 's/\+//g'`
	#TEMP=`cat /proc/acpi/thermal_zone/TZ00/temperature | sed 's/temperature:             //' | sed 's/ C//'`
	echo -en "$TEMP"
}

mpdtitle() {
	if mpc | grep -q "playing"; then
		TITLE=`mpc -f "%artist% - %title%" | head -n 1`
		echo -n "$TITLE$D"
	else
		echo -n ""
	fi
}

dbox() {
	DBSTATUS=`dropbox status`
	icon="\uE147"
	if [ "$DBSTATUS" = "Up to date" ]; then
		echo -en " \x05$icon"
	elif [ "$DBSTATUS" = "Connecting..." ]; then
		echo -en ""
	elif [ "$DBSTATUS" = "Dropbox isn't running!" ]; then
		echo -en ""
	else
		echo -en " \x01$icon"
	fi
}

torrent() {
	if [ `pgrep -f transmission-daemon` ]; then
		DOWNSPEED=`transmission-remote -l | awk '/^Sum/ {print $5}'`
		if [ "$DOWNSPEED" = "" ]; then
			echo -en "[_]"
		else
			echo -en "[t]"
		fi
	else
		echo -en ""
	fi
}

weather() {
	LOC=12330 # Poznan
	#LOC=12360 # Plock
	CURRENTWEATHER=`curl --silent http://rss.wunderground.com/auto/rss_full/global/stations/$LOC.xml?units=metric | grep Current`
	CURRENT_TEMP=`echo -n $CURRENTWEATHER | awk '{print $4}' | sed -e 's/C,//'`
	#CURRENT_COND=`echo -n $CURRENTWEATHER | awk '{print $5 $6}'`
	echo -en "\x01$CURRENT_TEMP\x07C"
}

data() {
	echo -en "\x01`date +\"%-d-%-m-%-y %H:%M\"`"
}

data_nocolor() {
	echo -en "`date +\"%-d-%-m-%-y %H:%M\"`"
}

dysk() {
	DISKINFO=`df -h -x udf -x tempfs -x iso9660 | sed -e "s/\%//" | awk '/^\/dev\//{if($5>90) if($5>98) print "\x04[" $6 " "$4 "]"; else print "\x03["$6" "$4 "]"; else print "\x01["$6 " "$4"]"}' | grep -v "boot" | sed -e 's/\/media\///' | sed -e "s/\/home/~/"`
	echo -n "\x01$DISKINFO"
}

dysk_nocolor() {
	DISKINFO=`df -h -x udf -x tempfs -x iso9660 | sed -e "s/\%//" | awk '/^\/dev\//{if($5>90) if($5>98) print "[" $6 " "$4 "]"; else print "["$6" "$4 "]"; else print "["$6 " "$4"]"}' | grep -v "boot" | sed -e 's/\/media\///' | sed -e "s/\/home/~/"`
	echo -n "$DISKINFO"
}

function netspeed
{
	RXB=$(cat /sys/class/net/$1/statistics/rx_bytes)
	TXB=$(cat /sys/class/net/$1/statistics/tx_bytes)
	sleep 0.5
	RXBN=$(cat /sys/class/net/$1/statistics/rx_bytes)
	TXBN=$(cat /sys/class/net/$1/statistics/tx_bytes)
	RXDIF=$(echo $((RXBN - RXB)) )
	TXDIF=$(echo $((TXBN - TXB)) )
	RX=$((RXDIF/512))
	TX=$((TXDIF/512))
	echo -n "$RX/$TX"
}

# looks for Pidgin windows having a '*' in their window title
pidgin() {
	icon="\uE1AF"
	wid=`wmctrl -lp | grep $(pidof pidgin) | awk '/*/ {print $1}' | head -n 1`
	if [ $wid ]; then
		echo -en " ^ca(1, xdotool windowactivate $wid)^fg(#B716D0)$icon^fg()^ca()"
	fi
}

spoticon() {
	icon="\x05\uE04D"
	if pidof spotify > /dev/null; then
		echo -en " $icon"
	else
		echo -en ""
	fi
}

batt() {
	STAT=$(cat /sys/class/power_supply/BAT0/status)
    CNOW=$(cat /sys/class/power_supply/BAT0/charge_now)
    CFULL=$(cat /sys/class/power_supply/BAT0/charge_full)
	PERC=$((CNOW*100/CFULL))
	if [ "$STAT" == "Full" ]; then
		echo -en "\x05BAT0: Full\x01"
	elif [ "$STAT" == "Charging" ]; then
		echo -en "\x05BAT0: $PERC%$(bar $PERC 8)\x01"
	else
		echo -en "\x05BAT0: \x01$PERC%$(bar $PERC 8)\x01"
	fi
}

bar()
{
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

mem() {
	MEMF=$(cat /proc/meminfo | grep -i MemFree | awk '{print $2}')
	MEMT=$(cat /proc/meminfo | grep -i MemTotal | awk '{print $2}')
	MEM=$(($MEMF*100/$MEMT))
	echo -en "\x01mem:$(bar $MEM 5) $MEM%\x01"
}

dzen_pager() {
	cur_desk=`xprop -root | grep '_NET_CURRENT_DESKTOP(CARDINAL*' | awk '{print $3}'`
	cur_desk=$(($cur_desk+1))
	all_desk=`xprop -root | grep '_NET_NUMBER_OF_DESKTOPS(CARDINAL*' | awk '{print $3}'`
	icon="^r(7x7)"
	echo -n "  "
	for i in $(seq $all_desk); do
		if [ "$i" = "$cur_desk" ]; then
		   echo -n "^ca(1, wmctrl -s $(($i-1)))$icon^ca() "
		else
		   echo -n "^ca(1, wmctrl -s $(($i-1)))^fg(#404040)$icon^fg()^ca() "
		fi
	done
}
