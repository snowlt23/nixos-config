# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ stdenv, config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};

  optDesktop = lst: (if (builtins.pathExists ./desktop) then
      lst
    else
      []);
  optLaptop = lst: (if (builtins.pathExists ./laptop) then
      lst
    else
      []);

  xkeysnail = pkgs.python37Packages.buildPythonPackage {
    pname = "xkeysnail";
    version = "0.2.0";
    src = pkgs.fetchFromGitHub {
      owner = "mooz";
      repo = "xkeysnail";
      rev = "7ca27e0ada406cfccc5aed051e1a75618fee196b";
      sha256 = "1hv5yb87dx7imizdwmxsfbm9w4q8hck95pn4ndndhngphic1h057";
    };
    doCheck = false;
    propagatedBuildInputs = [
      pkgs.python37Packages.xlib
      pkgs.python37Packages.evdev
      pkgs.python37Packages.inotify-simple
    ];
  };
in
{
  imports =
    (if (builtins.pathExists /mnt/etc/nixos/hardware-configuration.nix) then [ /mnt/etc/nixos/hardware-configuration.nix ]
     else [ /etc/nixos/hardware-configuration.nix ]) ++
    optDesktop [./desktop-configuration.nix] ++
    optLaptop [./laptop-configuration.nix] ;

  system = {
    stateVersion = "19.09";
  };

  # Packages
  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableTridactylNative = true;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
      emacs = pkgs.emacs.override { imagemagick = pkgs.imagemagickBig; };
      # Override bluez for a2dp bug at reconnecting.
      bluez = pkgs.stdenv.lib.overrideDerivation pkgs.bluez (oldAttrs: {
        name = "bluez-git";
        src = pkgs.fetchgit {
          url = git://git.kernel.org/pub/scm/bluetooth/bluez.git;
          rev = "b6960209ee3e0166353060deb38eb7827a092ed3";
          sha256 = "1llz9imdws5fkfwj7h7awncwmaax0zl58lkmil7s9b7w0191273j";
        };
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.automake pkgs.autoconf pkgs.libtool ];
        patches = [];
        preConfigure = ''
          ./bootstrap
        '';
      });
    };
  };

  # Package list
  environment.systemPackages = with pkgs; [
    wget xsel unar ranger fzf powerline-go
    acpi volnoti pamixer pavucontrol compton feh libnotify dunst powertop moc scrot
    (python35.withPackages(ps: with ps; [ pip setuptools ]))
    ffmpeg imagemagick vorbis-tools youtube-dl
    neovim emacs git gnumake gcc
    rxvt_unicode tmux mosh
    firefox tridactyl-native
    nextcloud-client
    discord
    libva vaapiVdpau
    xkeysnail
    unstable.wineWowPackages.stable unstable.winetricks
    adapta-gtk-theme gnome3.adwaita-icon-theme
  ] ++
  optDesktop [ krita ] ++
  optLaptop [ ] ;

  networking.hostName = "snowlt23-pc";
  networking.networkmanager.enable = true;
  #networking.wireless.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true;
    defaultLocale = "ja_JP.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Using Xmonad
  services.xserver = {
    enable = true;

    layout = "us,ua";
    xkbOptions = "caps:escape";

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        rofi
        polybar
        i3status
      ];
    };
    libinput.enable = true;
    libinput.tapping = false;
    libinput.tappingDragLock = false;
    libinput.naturalScrolling = true;

    config = ''
      Section "InputClass"
        Identifier    "ELECOM TrackBall Mouse DEFT Pro TrackBall"
        MatchProduct  "ELECOM TrackBall Mouse DEFT Pro TrackBall"
        Driver        "libinput"
        Option        "ScrollMethod" "button"
        Option        "ScrollButton" "8"
        Option        "ButtonMapping" "1 2 3 4 5 6 7 8 3"
        Option        "MiddleEmulation" "on"
        Option        "AccelSpeed" "-1.0"
      EndSection
    '';

    displayManager.sessionCommands = ''
      feh --bg-center /home/snowlt23/Pictures/wallpaper.png &
    '';
  };

  # TLP
  services.tlp.enable = true;
  xdg.portal.enable = true;
  # Flatpak
  services.flatpak.enable = true;

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      noto-fonts-cjk
      ipafont
      ubuntu_font_family
      dejavu_fonts
      hack-font
      powerline-fonts

      material-icons
      font-awesome-ttf
    ];

    fontconfig = { 
      defaultFonts = {
        monospace = [ 
          "DejaVu Sans Mono for Powerline"
          "IPAGothic"
        ];
        serif = [ 
          "DejaVu Serif"
          "IPAPMincho"
        ];
        sansSerif = [
          "DejaVu Sans"
          "IPAPGothic"
        ];
      };
    };
  };

  # user
  users.extraUsers.snowlt23 = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "i2c" "input" ];
  };

  # input method for JP
  i18n.inputMethod = {
    enabled  = "uim";
  };

  # virtualisation
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  boot.kernelModules = [ "uinput" ];

  # steam
  users.extraUsers.snowlt23.packages = [
    pkgs.steam pkgs.lutris
  ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.steam-hardware.enable = true;
  # for Steam Link
  networking.firewall = {
     allowedTCPPorts = [ 27036 27037 9000 3478 ];
     allowedUDPPorts = [ 27031 27036 9000 3478 ];
  };
}
