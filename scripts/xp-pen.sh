#!/bin/sh
devid=$(xinput | grep "XP-PEN DECO 02 Pen" | grep -o -E 'id=[0-9]+' | sed 's/id=//g')
xinput --map-to-output $devid DVI-D-0
