#!/bin/bash

if pgrep -x clipse > /dev/null; then
    pkill -x clipse
else
    foot -a clipse -e clipse
fi
