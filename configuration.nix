# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ stdenv, config, pkgs, ... }:

{
  imports =
    (if (builtins.pathExists /mnt/etc/nixos/hardware-configuration.nix) then [ /mnt/etc/nixos/hardware-configuration.nix ]
     else [ /etc/nixos/hardware-configuration.nix ]) ++
    [
      ./laptop-configuration.nix
    ];

  system = {
    stateVersion = "19.03";
  };

  # Common
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
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
    wget xsel unar ranger
    xmobar dmenu trayer
    acpi volnoti pamixer flameshot compton feh libnotify notify-osd-customizable
    networkmanager_dmenu
    python3 ruby
    neovim git gnumake gcc
    rxvt_unicode
    dropbox firefox brave luakit
    google-play-music-desktop-player
  ];

  networking.hostName = "snowlt23-pc";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "jp106";
    defaultLocale = "ja_JP.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Using Xmonad
  services.xserver = {
    enable = true;
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
    libinput.enable = true;
    libinput.tapping = false;
    libinput.tappingDragLock = false;

    displayManager.sessionCommands =  ''
      compton --config ~/.config/compton.conf --xrender-sync --xrender-sync-fence -b
      trayer --edge top --align right --expand true --width 10 --transparent true --height 20 --tint 0x1c1c1c --alpha 0 &
      volnoti
      feh --bg-center /home/snowlt23/Pictures/wallpaper.png &
    '';
  };

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      dejavu_fonts
      font-awesome-ttf
      ubuntu_font_family
      source-code-pro
      source-sans-pro
      source-serif-pro
      hack-font
      ipafont
    ];

    fontconfig = { 
      defaultFonts = {
        monospace = [ 
          "DejaVu Sans Mono for Powerline"
          "IPAGothic"
          "Baekmuk Dotum"
        ];
        serif = [ 
          "DejaVu Serif"
          "IPAPMincho"
          "Baekmuk Batang"
        ];
        sansSerif = [
          "DejaVu Sans"
          "IPAPGothic"
          "Baekmuk Dotum"
        ];
      };
    };
  };

  # user
  users.extraUsers.snowlt23 = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  # input method for JP
  i18n.inputMethod = {
    enabled  = "uim";
  };

  # steam
  users.extraUsers.snowlt23.packages = [
    pkgs.steam
  ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.steam-hardware.enable = true;
  # for Steam Link
  networking.firewall = {
     allowedTCPPorts = [ 27036 27037 ];
     allowedUDPPorts = [ 27031 27036 ];
  };
}
