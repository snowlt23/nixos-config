source $stdenv/setup
PATH=$dpkg/bin:$PATH
dpkg -x $src unpacked
mkdir -p $out/
cp -r unpacked/usr/* $out/
