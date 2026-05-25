#!/usr/bin/env bash

PLAYERS=$(playerctl -l)
PLAYING_OUTPUT=""
DEFAULT_OUTPUT=""

if [[ -z "$PLAYERS" ]]; then
    echo ""
    exit
fi

while read -r player; do
    STATUS=$(playerctl -p $player status)
    TITLE=$(playerctl -p $player metadata title)
    ARTIST=$(playerctl -p $player metadata artist)

    ICON="▶"
    if [[ "$STATUS" == "Paused" ]]; then
        ICON="⏸"
    fi

    if [[ ! -z "$STATUS" ]]; then
        DEFAULT_OUTPUT="$ICON $ARTIST - $TITLE"
    fi
    if [[ "$STATUS" == "Playing" ]]; then
        PLAYING_OUTPUT="$ICON $ARTIST - $TITLE"
    fi
done <<< "$PLAYERS"

if [[ -z "$DEFAULT_OUTPUT" ]]; then
    echo ""
    exit
fi

if [[ -z "$PLAYING_OUTPUT" ]]; then
    echo $DEFAULT_OUTPUT
else
    echo $PLAYING_OUTPUT
fi