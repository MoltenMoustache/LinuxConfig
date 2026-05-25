#!/usr/bin/env bash

CSS_FILE="$HOME/.config/waybar/gruvbox-colours.css"

get_color() {
    grep "$1" "$CSS_FILE" | grep -oP '#[0-9a-fA-F]{3,8}' | head -1
}

bg=$(get_color "bg")
bg_s=$(get_color "bg_s")
bg1=$(get_color "bg1")
bg2=$(get_color "bg2")
bg3=$(get_color "bg3")
fg=$(get_color "fg")
orange=$(get_color "orange")

FOLDER="$HOME/Documents/ObsidianVault"

try-open () {
    if ! pgrep -f "/usr/lib/obsidian/app.asar" > /dev/null; then
        obsidian &
        sleep 1
    fi
}

RECENT_NOTES=$(find "$FOLDER" -type f -name "*.md" -printf '%A@ %P\n' | sort -nr | cut -d' ' -f2-)

CHOICE=$(
    printf "➕ New Note\n%s\n" "$RECENT_NOTES" | 
    bemenu \
    --fb "$bg_s" \
    --ff "$fg" \
    --nb "$bg_s" \
    --nf "$fg" \
    --hb "$bg3" \
    --hf "$orange" \
    --tb "$bg_s" \
    --tf "$fg" \
    --ab "$bg1" \
    --af "$fg" \
    --border 2 \
    --bdr "$bg" \
    -R 5 \
    --counter always \
    --line-height 24 \
    -c -l 10 -i -W 0.25 -p "Open or type new note: ") || exit 0

if [[ $CHOICE == "➕ New Note" ]]; then
    NAME=$(echo "" | bemenu \
    --fb "$bg_s" \
    --ff "$fg" \
    --nb "$bg_s" \
    --nf "$fg" \
    --hb "$bg3" \
    --hf "$orange" \
    --tb "$bg_s" \
    --tf "$fg" \
    --ab "$bg1" \
    --af "$fg" \
    --border 2 \
    --bdr "$bg" \
    -R 5 \
    --line-height 32 \
    -c -sb "#a3be8c" -nf "#d8dee9" -W 0.25 -p "Enter a name: ") || exit 0

    DIR=$(
    {
        printf ".\n"
        find "$FOLDER" -mindepth 1 -type d -printf "%T@ %p\n" \
        | sort -rn \
        | sed "s|^[0-9.]* $FOLDER/||"
    } \
    | bemenu \
    --fb "$bg_s" \
    --ff "$fg" \
    --nb "$bg_s" \
    --nf "$fg" \
    --hb "$bg3" \
    --hf "$orange" \
    --tb "$bg_s" \
    --tf "$fg" \
    --ab "$bg1" \
    --af "$fg" \
    --border 2 \
    --bdr "$bg" \
    -R 5 \
    --line-height 24 \
    -c -l 5 -i -W 0.25 -p "Choose directory: "
) || exit 0

    # Default to root
    DIR=${DIR:-"."}

    try-open
    obsidian create path="$DIR/$NAME" open
else
    try-open
    obsidian open path="$CHOICE"
fi
