#!/bin/sh
pactl $@
volnoti-show $(pamixer --get-volume)
