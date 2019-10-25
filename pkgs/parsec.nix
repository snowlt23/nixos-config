let
  nixpkgs = import <nixpkgs> {};
  stdenv = nixpkgs.stdenv;
in rec {
  dumb-parsecd = stdenv.mkDerivation {
    name = "dumb-parsecd";
    builder = ./parsec-builder.sh;
    dpkg = nixpkgs.dpkg;
    src = nixpkgs.fetchurl {
      url = "https://s3.amazonaws.com/parsec-build/package/parsec-linux.deb";
      sha256 = "0wx2nchjr0cbd8a9wdq38wf6kiyxw6892gda4a69w670pqg9bvdy";
    };
  };
  full-parsecd = nixpkgs.buildFHSUserEnv {
    name = "full-parsecd";
    targetPkgs = pkgs: (with pkgs; [
      stdenv.cc.cc stdenv.cc.libc cairo freetype libgcc gdk_pixbuf libGL glib gtk3 pango xorg.libSM xorg.libX11 xorg.libXxf86vm
      #libva vaapiVdpau
      dumb-parsecd
    ]);
    multiPkgs = pkgs: [ pkgs.dpkg ];
    runScript = "parsecd";
  };
}
