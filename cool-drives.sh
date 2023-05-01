#!/usr/bin/env /usr/local/bin/bash

# Must be root
if [ $EUID -ne 0 ]
then
    echo running the script as root
    exec sudo "$0" "$@"
fi

# init temp variable
max_temp=0

# scan all (?) SATA drives, find maximum temperature
for drive in /dev/ada?
do
    temp=$(smartctl -a "$drive" | grep "194 Temp" | awk '{print $10}')
    #echo $temp
    if [ $temp -gt $max_temp ]
    then
        max_temp="$temp"
    fi
done
echo "Max $max_temp"

# Get current state of the outlet
outlet_state=$(tplink_smartplug.py -t 192.168.20.65 -c info | \
  tail -1|sed 's/Received://'|jq '.system.get_sysinfo.relay_state')

echo "outlet_state $outlet_state"

if [ $max_temp -gt 40 ] && [ $outlet_state -eq 0 ]
then
    echo turn fan on
    tplink_smartplug.py -t 192.168.20.65 -c on
elif [ $max_temp -lt 38 ]  &&  [ $outlet_state -eq 1 ]
then
    echo turn fan off
    tplink_smartplug.py -t 192.168.20.65 -c off
fi
