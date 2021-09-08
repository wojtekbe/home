#!/bin/bash
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

