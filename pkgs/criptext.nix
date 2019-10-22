with import <nixpkgs> {};

stdenv.mkDerivation {
  pname = "criptext";
  version = "0.23.10";

  src = fetchurl {
    url = "https://cdn.criptext.com/Criptext-Email-Desktop/linux/Criptext-latest.AppImage";
    sha256 = "23eb24f799ee39837f34f8a6cf40f6785ef81034ab7e7b023284b658e3417052";
  };
  buildInputs = [ appimage-run ];

	dontUnpack = true;
	installPhase = ''
		mkdir -p $out/{bin,share}
		cp $src $out/share/Criptext-latest.AppImage
		echo "#!${runtimeShell}" > $out/bin/Criptext
		echo "${appimage-run}/bin/appimage-run $out/share/Criptext-latest.AppImage" >> $out/bin/Criptext
		chmod +x $out/bin/Criptext $out/share/Criptext-latest.AppImage
	'';

  meta = with stdenv.lib; {
    description = "";
    longDescription = ''
    '';
    homepage = https://criptext.com;
    license = licenses.agpl3;
    maintainers = with maintainers; [ snowlt23 ];
    platforms = [ "x86_64-linux" ];
  };
}
