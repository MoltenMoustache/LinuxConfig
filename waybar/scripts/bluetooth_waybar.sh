#!/bin/bash

status=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
if [ "$status" == "no" ]; then
    bluetoothctl power on
    bluetoothctl scan on
else
    bluetoothctl power off
fi