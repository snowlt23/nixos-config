#!/bin/sh

cp .bashrc ~/.bashrc
cp .bash_profile ~/.bash_profile
cp .Xresources ~/.Xresources
cp .tmux.conf ~/.tmux.conf
cp .notify-osd ~/.notify-osd

rm -rf ~/.xmonad
cp -r .xmonad ~/.xmonad

cp -r .config/* ~/.config/
cp .config/luakit/userconf.lua ~/.config/luakit/userconf.lua
cp .config/luakit/theme.lua ~/.config/luakit/theme.lua

cd ~/.mozilla/firefox
ls -1 | while read F ; do
  if [ -d "$F" ] ; then
    mkdir -p "$F/chrome"
    cp ~/nixos-config/userChrome.css "$F/chrome/userChrome.css"
  fi
done
