#!/bin/sh
choice=$(printf "󰌾 Lock\n󰤄 Suspend\n󰜉 Reboot\n⏻ Shutdown" | rofi -dmenu -theme DarkBlue -p "Power")

case "$choice" in
    "󰌾 Lock") hyprlock ;;
    "󰤄 Suspend") systemctl suspend ;;
    "󰜉 Reboot") systemctl reboot ;;
    "⏻ Shutdown") systemctl poweroff ;;
esac
