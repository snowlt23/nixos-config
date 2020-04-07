#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log
M=eDP-1
if [ -f ~/nixos-config/desktop ] && [ "$(xrandr grep DisplayPort)" = "" ] ; then
  M=DP-2
elif [ -f ~/nixos-config/desktop ] ; then
  M=DisplayPort-1
fi
MONITOR=$M polybar main >>/tmp/polybar1.log 2>&1 &

echo "Bars launched..."
