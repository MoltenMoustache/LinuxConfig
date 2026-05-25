#!/bin/bash

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

echo "$BG"
exec bemenu-run \
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
    -c \
    -W 0.1 \
    -l 8 \
    --line-height 32 \
    --border 2 \
    --bdr "$bg" \
    -R 5 \
    --counter always \
    --accept-single \
    -p "Launch:"