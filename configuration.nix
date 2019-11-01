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
    stateVersion = "19.09";
  };

  # Packages
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
      criptext = import ./pkgs/criptext.nix;
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
    home-manager
    wget xsel unar ranger
    albert acpi volnoti pamixer flameshot compton feh libnotify dunst
    networkmanager_dmenu
    python3 ruby ffmpeg
    neovim emacs git gnumake gcc
    rxvt_unicode tmux mosh
    fcitx-engines.skk
    brave
    discord
    libva vaapiVdpau
    #criptext
  ];

  networking.hostName = "snowlt23-pc";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;

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

    displayManager.sessionCommands =  ''
    '';
  };

  # Cron
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *      snowlt23    . /home/snowlt23/.bashrc; battery-notify.sh"
    ];
  };

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      fantasque-sans-mono
      material-icons
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
    extraGroups = [ "wheel" "i2c" ];
  };

  # input method for JP
  i18n.inputMethod = {
    enabled  = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ skk ];
  };

  # virtualisation
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  # steam
  users.extraUsers.snowlt23.packages = [
    pkgs.steam
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
