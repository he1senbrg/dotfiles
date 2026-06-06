#!/bin/bash

if pgrep -x fuzzel > /dev/null; then
    pkill -x fuzzel
else
    fuzzel --config="$HOME/dotfiles/fuzzel/fuzzel.ini"
fi
