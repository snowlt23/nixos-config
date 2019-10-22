#!/bin/sh
bat=$(battery.sh)
ac=$(acpower.sh)
if [[ $ac -eq 1 && $bat -eq 100 ]] ; then
  battery-charged
fi

if [[ $ac -eq 0 && $bat -lt 20 ]] ; then
  low-battery
fi
