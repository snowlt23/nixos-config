#!/bin/sh

CODEC_DEB=chromium-codecs-ffmpeg-extra_71.0.3578.98-0ubuntu0.16.04.1_amd64.deb
wget http://launchpadlibrarian.net/401553574/$CODEC_DEB
ar p $CODEC_DEB data.tar.xz | tar xJf - ./usr/lib/chromium-browser/libffmpeg.so --strip 4
mkdir -p ~/.local/lib/vivaldi
mv libffmpeg.so ~/.local/lib/vivaldi/libffmpeg.so
rm $CODEC_DEB
