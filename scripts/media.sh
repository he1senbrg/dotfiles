#!/bin/bash

if pgrep -x media > /dev/null; then
    pkill -x media
else
    $HOME/scripts/media
fi
