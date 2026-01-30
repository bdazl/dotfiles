#!/bin/sh
player_status=$(playerctl status 2>/dev/null)
case "$player_status" in
    Playing|Paused)
        artist=$(playerctl metadata artist)
        title=$(playerctl metadata title)
        [ "$player_status" = "Paused" ] && printf "󰏤 " || printf ""
        printf "%s - %s\n" "$artist" "$title"
        ;;
esac
