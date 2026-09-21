#!/bin/sh
choice=$(printf '󰌾 Lock\n󰤄 Suspend\n󰜉 Reboot\n⏻ Shutdown' | rofi -dmenu -theme "$HOME/.config/rofi/catppuccin.rasi" -p Power)

case "$choice" in
    '󰌾 Lock') swaylock -f ;;
    '󰤄 Suspend') systemctl suspend ;;
    '󰜉 Reboot') systemctl reboot ;;
    '⏻ Shutdown') systemctl poweroff ;;
esac
