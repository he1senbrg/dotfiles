#!/bin/bash

# Check if Rofi is already running
if pgrep -x rofi > /dev/null; then
    # Rofi is running, so kill it
    pkill -x rofi
else
    # Rofi is not running, so launch it with the custom config
    /home/loki/.config/rofi/scripts/powermenu_t2
fi
