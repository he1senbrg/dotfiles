#!/usr/bin/env bash

set -euo pipefail

THEME="$HOME/dotfiles/rofi/power_menu.rasi"

SHUTDOWN=''
REBOOT=''
LOCK=''
SUSPEND=''
LOGOUT=''

YES=''
NO=''

UPTIME="$(uptime -p | sed 's/^up //')"

rofi_menu() {
    rofi -dmenu \
        -p "Uptime: $UPTIME" \
        -mesg "Uptime: $UPTIME" \
        -theme "${THEME}"
}

rofi_confirm() {
    echo -e "${YES}\n${NO}" | rofi \
        -dmenu \
        -p "Confirmation" \
        -mesg "Are you sure?" \
        -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -theme "${THEME}"
}

confirm() {
    [[ "$(rofi_confirm)" == "$YES" ]]
}

shutdown() {
    systemctl poweroff
}

reboot() {
    systemctl reboot
}

lock() {
    swaylock -c 000000
}

suspend() {
    systemctl suspend
}

logout() {
    niri msg action quit -s
}

show_menu() {
    echo -e \
        "${SHUTDOWN}\n${LOCK}\n${REBOOT}\n${LOGOUT}\n${SUSPEND}" |
        rofi_menu
}

main() {
    case "$(show_menu)" in
        "$LOCK")
            lock
            ;;
        "$SHUTDOWN")
            confirm && shutdown
            ;;
        "$REBOOT")
            confirm && reboot
            ;;
        "$SUSPEND")
            confirm && suspend
            ;;
        "$LOGOUT")
            confirm && logout
            ;;
    esac
}

main