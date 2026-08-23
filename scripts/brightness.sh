#!/bin/bash

show_osd() {
    local icon="$1" cur="$2" cur_f="$3"
    swayosd-client --custom-progress "$cur_f" --custom-progress-text "$cur" --custom-icon "$icon"
}

out=$(niri msg focused-output | sed -E 's/.*\(([^)]+)\).*/\1/')

case "$out" in
    eDP*)
        cur=$(brightnessctl -m | cut -d, -f4)
        cur=${cur%\%}
        cur_f=$(awk "BEGIN {printf \"%.2f\", $cur / 100}")

        if [[ $1 == "+" && $cur -ge 98 ]]; then
            show_osd laptop-symbolic "$cur" "$cur_f"
            exit 0
        fi

        brightnessctl set "02%$1"
        read -r cur cur_f <<< "$(brightnessctl -m | awk -F, '{printf "%.0f %.2f\n", $4, $4/100}')"
        show_osd laptop-symbolic "$cur" "$cur_f"
        ;;

    HDMI*)
        ddcutil setvcp 10 "$1" 5
        read -r cur cur_f <<< "$(ddcutil getvcp 10 | awk -F'current value =|,' '{val=$2+0; printf "%.0f %.2f\n", val, val/100}')"
        show_osd monitor-symbolic "$cur" "$cur_f"
        ;;
    *)
        ;;
esac