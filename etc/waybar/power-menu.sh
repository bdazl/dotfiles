#!/bin/sh
choice=$(printf "󰌾 Lock\n󰤄 Suspend\n󰜉 Reboot\n⏻ Shutdown" | rofi -dmenu -theme DarkBlue -p "Power")

case "$choice" in
    "󰌾 Lock")
        if command -v hyprlock >/dev/null 2>&1; then
            hyprlock
        else
            swaylock -f
        fi
        ;;
    "󰤄 Suspend") systemctl suspend ;;
    "󰜉 Reboot") systemctl reboot ;;
    "⏻ Shutdown") systemctl poweroff ;;
esac
