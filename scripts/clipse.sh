#!/bin/bash

if pgrep -x clipse > /dev/null; then
    pkill -x clipse
else
    footclient -a clipse -e clipse
fi
