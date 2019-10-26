#!/bin/sh
pamixer $@
muted=
if [ "$(pamixer --get-mute)" = "true" ] ; then
  muted=-m
fi
volnoti-show $muted $(pamixer --get-volume)
