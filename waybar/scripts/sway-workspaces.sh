#!/usr/bin/env bash

MAX_WORKSPACES=10

# Colors
COLOR_FOCUSED="#ffffff"
COLOR_OCCUPIED="#bbbbbb"
COLOR_EMPTY="#707070"
WEIGHT_FOCUSED="bold"
WEIGHT_NORMAL="normal"

# Get sway workspace info
WORKSPACES=$(swaymsg -t get_workspaces --raw)

for i in $(seq 1 $MAX_WORKSPACES); do
    COLOR="$COLOR_EMPTY"
    WEIGHT="$WEIGHT_NORMAL"

    # Extract the workspace block for this number
    WS_BLOCK=$(echo "$WORKSPACES" | grep -A10 "\"num\": $i" | head -n 12)

    if [[ -n "$WS_BLOCK" ]]; then

        # Check if focused
        FOCUSED=$(echo "$WS_BLOCK" | grep '"visible": true')

        if [[ -n "$FOCUSED" ]]; then
            COLOR="$COLOR_FOCUSED"
            WEIGHT="$WEIGHT_FOCUSED"
        else
            COLOR="$COLOR_OCCUPIED"
        fi
    fi

    printf "<span foreground='%s' weight='%s'>%d</span> " "$COLOR" "$WEIGHT" "$i"
done

echo