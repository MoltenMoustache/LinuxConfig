#!/usr/bin/env bash

WEATHER=$(curl wttr.in/London?format=3)
notify-send "$WEATHER" -u normal