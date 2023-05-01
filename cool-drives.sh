#!/bin/sh

#
max_temp=0

for drive in /dev/ada?
do
    temp=$(smartctl -a "$drive" | grep "194 Temp" | awk '{print $10}')
    #echo $temp
    if [ $temp \> $max_temp ]
    then
        max_temp="$temp"
    fi
done
echo "Max $max_temp"


if [ $max_temp \> 40 ]
then
    echo turn fan on
    tplink_smartplug.py -t 192.168.20.65 -c on
elif [ $max_temp \< 38 ]
then
    echo turn fan off
    tplink_smartplug.py -t 192.168.20.65 -c off
fi

