#!/bin/sh
pamixer $@
if [ "$(pamixer --get-mute)" = "true" ] ; then
  volnoti-show -m $(pamixer --get-volume)
else
  volnoti-show $(pamixer --get-volume)
fi
