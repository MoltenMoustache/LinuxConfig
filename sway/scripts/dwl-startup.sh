#!/bin/bash

# Kill already running duplicate process
_ps="waybar mako swaybg"
for _prs in $_ps; do
    if [ "$(pidof "${_prs}")" ]; then
         killall -9 "${_prs}"
    fi
 done

wlr-randr --output DP-1 --mode 3440x1440@100Hz
swaybg -i ~/Downloads/mountains.jpg -m fill &
