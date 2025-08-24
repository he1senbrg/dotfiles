#!/bin/bash

if pgrep -x waybar > /dev/null; then
    pkill -x waybar
    waybar & disown
else
    waybar & disown
fi
