NAME=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).name' | tr -d \")
echo $NAME
