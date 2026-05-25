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

get_devices () {
    upower -d | awk '/model:/{model=substr($0, index($0,$2))} /percentage:/{if(model) print model "|" $2; model=""}' | \
    while IFS='|' read -r model pct; do
        num="${pct//%/}"
        num="${num// /}"

        case "${model,,}" in
            *"controller"*) icon="🎮" ;;
            *"mouse"*)       icon="🖱️"  ;;
            *"logitech pro"*)       icon="🖱️"  ;; # logitech pro x 2
            *"keyboard"*)    icon="⌨️"  ;;
            *"headset"*|*"headphone"*) icon="🎧" ;;
            *"m1005922"*) model="Apollo" icon="💻";;
            *)             icon="📡" ;;
        esac

        if [ "$num" -lt 30 ]; then bat="🪫"
        else                         bat="🔋"
        fi

        echo "$icon $model | $bat ${num}%"
    done
}

DEVS=$(get_devices)

echo "$DEVS" | 
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
--line-height 32 \
-c -l 10 -i -W 0.25 -p "Devices: "