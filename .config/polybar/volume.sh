#!/bin/sh
volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n 3 | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
echo " $volume%"
