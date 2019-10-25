#!/bin/sh
xrandr --output VGA-0 --auto && xrandr --output DVI-D-1 --auto --right-of VGA-0 && xrandr --output HDMI-1 --auto --right-of DVI-D-0
