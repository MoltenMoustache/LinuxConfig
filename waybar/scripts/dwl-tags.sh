#!/usr/bin/env bash

STATE=$(dwlmsg -g -t | grep "tag ")
OUT=""

while read -r line; do
    TAG_INDEX=$(echo "$line" | awk '{print $3}')
    ACTIVE=$(echo "$line" | awk '{print $4}')
    OCCUPIED=$(echo "$line" | awk '{print $5}')
    URGENT=$(echo "$line" | awk '{print $6}')

    # Default color
    COLOR="#888888"
    WEIGHT="normal"

    if [[ $ACTIVE -eq 1 ]]; then
        COLOR="#ffffff"
        WEIGHT="bold"
    elif [[ $URGENT -eq 1 ]]; then
        COLOR="#ff5555"
    elif [[ $OCCUPIED -gt 0 ]]; then
        COLOR="#bbbbbb"
    fi

    # Output with Pango markup
    OUT+="<span foreground='$COLOR' weight='$WEIGHT'>$((TAG_INDEX+1))</span> "
done <<< "$STATE"

echo $OUT