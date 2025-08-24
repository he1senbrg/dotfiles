#!/bin/bash

# Check if Rofi is already running
if pgrep -x rofi > /dev/null; then
    # Rofi is running, so kill it
    pkill -x rofi
else
    # Rofi is not running, so launch it with the custom config
    /home/loki/dotfiles/rofi/launchers/type-1/launcher.sh
fi
