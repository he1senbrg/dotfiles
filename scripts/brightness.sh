#!/bin/bash

out=$(niri msg focused-output | grep '^Output' | sed -E 's/.*\(([^)]+)\).*/\1/')

case $out in
    eDP*)
        brightnessctl set 02%$1
        read -r cur cur_f <<< $(brightnessctl g | awk '{printf "%.0f %.2f\n", ($1 * 100 / 62194), ($1 / 62194)}')
        swayosd-client --custom-progress $cur_f --custom-progress-text $cur --custom-icon laptop-symbolic
        ;;

    HDMI*)
        ddcutil setvcp 10 $1 5
        read -r cur cur_f <<< $(ddcutil getvcp 10 | awk -F'current value =|,' '{val=$2+0; printf "%.0f %.2f\n", val, val/100}')
        swayosd-client --custom-progress $cur_f --custom-progress-text $cur --custom-icon monitor-symbolic
        ;;
    *)
        ;;
esac