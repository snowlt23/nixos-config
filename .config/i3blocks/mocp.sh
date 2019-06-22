#!/usr/bin/env bash
# mocp playing song script

case $BLOCK_BUTTON in
1) mocp -G ;; # left click = toggle pause - play
2) mocp -r ;; # middle click = previous song
3) mocp -f ;; # right click = next song
esac

maxlen=${BLOCK_INSTANCE:-30}
full_text="MOC not running!"
short_text="$full_text"
color="#505050"
if [[ ! -z $(pidof mocp) ]]
then

state=$(mocp -Q "%state" | sed -e 's/PLAY//' -e 's/PAUSE//' -e 's/STOP//')
file=$(basename "$(mocp -Q "%file" | sed -e 's/.ogg//g')")
artist=$(mocp -Q "%aritst")
full_text="$state  $file"
short_text="${full_text:0:$maxlen}"
color="#90A959"
fi
echo "    $short_text"
echo "$full_text"
echo "$color"

pkill -RTMIN+3 i3blocks
