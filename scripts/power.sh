#!/bin/bash

if pgrep -x rofi > /dev/null; then
    pkill -x rofi
else
    $HOME/dotfiles/rofi/power_menu.sh
fi
