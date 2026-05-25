#!/usr/bin/env bash

FOLDER="$HOME/Documents/ObsidianVault"

try-open () {
    if ! pgrep -f "/usr/lib/obsidian/app.asar" > /dev/null; then
        obsidian &
        sleep 1
    fi
}

# Get recent notes
RECENT_NOTES=$(find "$FOLDER" -type f -name "*.md" -printf '%T@ %P\n' | sort -nr | cut -d' ' -f2-)

CHOICE=$(
    printf "➕ New Note\n%s\n" "$RECENT_NOTES" | 
    bemenu -c -l 10 -i -W 0.3 -p "Open or type new note: ") || exit 0

if [[ $CHOICE == "➕ New Note" ]]; then
    NAME=$(echo "" | bemenu -c -sb "#a3be8c" -nf "#d8dee9" -W 0.3 -p "Enter a name: ") || exit 0

    DIR=$(
        { printf ".\n"; find "$FOLDER" -type d | sed "s|^$FOLDER/||"; } \
        | sort -nr \
        | bemenu -c -l 5 -i -W 0.3 -p "Choose directory: "
    ) || exit 0

    # Default to root
    DIR=${DIR:-"."}

    try-open
    obsidian create path="$DIR/$NAME" open
else
    try-open
    obsidian open path="$CHOICE"
fi
