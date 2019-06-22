let nixpkgs = import <nixpkgs> {};
    stdenv = nixpkgs.stdenv;

in rec {
  gpmdp = stdenv.mkDerivation {
    name = "gpmdp";
    builder = ./builder.sh;
    dpkg = nixpkgs.dpkg;
    src = nixpkgs.fetchurl {
      url = "https://github.com/MarshallOfSound/Google-Play-Music-Desktop-Player-UNOFFICIAL-/releases/download/v4.6.1/google-play-music-desktop-player_4.6.1_amd64.deb";
      sha256 = "4f48764eacd28370c3fadfc99540d62f9de78dfe3a5f566d6a296606bb13d637";
    };
  };
  gpmdp-env = nixpkgs.buildFHSUserEnv {
    name = "gpmdp-env";
    targetPkgs = pkgs: with pkgs; [
      alsaLib atk cairo cups dbus expat file fontconfig freetype gdb git glib 
      gnome2.GConf gnome2.gdk_pixbuf gnome2.gtk gnome2.pango gnome3.gtk libnotify libxml2 libxslt
      netcat nspr nss strace udev watch wget which xorg.libX11
      xorg.libXScrnSaver xorg.libXcomposite xorg.libXcursor xorg.libXdamage
      xorg.libXext xorg.libXfixes xorg.libXi xorg.libXrandr xorg.libXrender
      xorg.libXtst xorg.libxcb xorg.xcbutilkeysyms zlib zsh
      gpmdp
    ];
    multiPkgs = pkgs: [ pkgs.dpkg ];
    runScript = "google-play-music-desktop-player";
  };
}
