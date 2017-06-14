#!/bin/bash

FAN_FILE_PATH="/sys/devices/platform/applesmc.768/fan1_min"
CRITICAL_TEMP=90
HIGH_TEMP=80
MODERATE_TEMP=70
NORMAL_TEMP=60

max_temp=0
all_temp=`sensors | grep '+' | awk -F'[+ :.]' '{print $11,$12}' | sed 's/^[ \t]*//' | sed '/^$/d' | sed '/^[^0-9]/d' | cut -d' ' -f1`

for temp in $all_temp; do
    if [[ $max_temp -lt $temp ]]; then
	max_temp=$temp
    fi
done

if [[ $max_temp -gt $CRITICAL_TEMP  ]]; then
    sudo echo "6000" > $FAN_FILE_PATH
elif [[ $max_temp -gt $HIGH_TEMP  ]]; then
    sudo echo "5000" > $FAN_FILE_PATH
elif [[ $max_temp -gt $MODERATE_TEMP  ]]; then
    sudo echo "4000" > $FAN_FILE_PATH
elif [[ $max_temp -gt $NORMAL_TEMP  ]]; then
    sudo echo "3000" > $FAN_FILE_PATH
else
    sudo echo "2000" > $FAN_FILE_PATH
fi
