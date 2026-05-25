#2!/usr/bin/env bash

case "$(printf "kill\nreboot\nshutdown" | bemenu -i -c -l 4 -W 0.1)" in
	kill) ps -u "$USER" -o pid,comm,%cpu,%mem | bemenu -i -c -l 10 -W 0.3 --counter always -p Kill: | awk '{print $1}' | xargs -r kill ;;
	reboot) systemctl reboot -i ;;
	shutdown) shutdown now ;;
	*) exit 1 ;;
esac
