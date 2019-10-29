with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "xp-pen";
  version = "1.3.0.0";

  src = fetchurl {
    url = "https://download01.xp-pen.com/file/2019/08/Linux%20Beta%20Driver(20190820).zip";
    name = "Linux_Beta_Driver_20190820_.zip";
    sha256 = "0m3w8zb9ymdz07fi0674y99k0d6y20p7l2hbslb899c9apv33g0c";
  };

  phases = [ "unpackPhase" "installPhase" "postFixup" ];

  buildInputs = [
    unar qt5.wrapQtAppsHook
    libusb1 xorg.libX11 xorg.libXtst xorg.libxcb
    qt5.qtbase
    libGL xorg.libpthreadstubs
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    unar $src
    unar "Linux Beta Driver(20190820)/Linux_Pentablet_V1.3.0.0.tar.gz"
  '';

  libPath = stdenv.lib.makeLibraryPath buildInputs;
	installPhase = ''
		mkdir -p $out/{bin,share}
    cp -r Linux_Pentablet_V1.3.0.0/* $out/bin/
    patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) --set-rpath ${libPath} $out/bin/Pentablet_Driver
	'';

  dontWrapQtApps = true;
  postFixup = ''
    wrapQtApp $out/bin/Pentablet_Driver
  '';

  meta = with stdenv.lib; {
    description = "";
    longDescription = ''
    '';
    homepage = https://xp-pen.jp;
    #license = licenses.unfree;
    maintainers = with maintainers; [ snowlt23 ];
    platforms = [ "x86_64-linux" ];
  };
}
