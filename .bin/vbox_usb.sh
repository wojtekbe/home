#!/bin/bash
VM=$1
STATE_UUID=`vboxmanage list usbhost | awk '/UUID/ {id=$2; prod=""; state="[ ]"} /Product:/ {for(f=2; f<=NF; f++) {prod=prod " " $f};} /Current State/ {if($3=="Captured") state="[*]"; print state " " prod " " id} ' | fzf --height 15 --prompt "$VM: attach/detach USB device: " | awk '{print $1 " " $(NF)}'`

if [ "$STATE_UUID" == "" ]; then
    exit
fi

CMD=`echo $STATE_UUID | awk '{if($1=="[*]") {print "usbdetach"} else {print "usbattach"}}'`
UUID=`echo $STATE_UUID | awk '{print $2}'`

echo "vboxmanage controlvm $VM $CMD $UUID"
vboxmanage controlvm win10 $CMD $UUID
