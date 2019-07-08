# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ stdenv, config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./laptop-configuration.nix
    ];

  system = {
    stateVersion = "18.09";
  };

  # Common
  nixpkgs.config.allowUnfree = true;

  # Package list
  environment.systemPackages = with pkgs; [
    wget xsel unar
    i3blocks acpi pamixer flameshot compton feh libnotify notify-osd
    networkmanager_dmenu
    python3
    neovim emacs git gnumake gcc
    tmux peco python37Packages.powerline rxvt_unicode
    dropbox firefox brave
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

  # i3wm
  services.xserver = {
    enable = true;
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    windowManager.i3.enable = true;
    libinput.enable = true;
    libinput.tapping = false;
    libinput.tappingDragLock = false;

    displayManager.sessionCommands =  ''
      compton &
      feh --bg-scale /home/snowlt23/Pictures/wallpaper.png &
      dropbox &
      xrdb "${pkgs.writeText  "xrdb.conf" ''
          URxvt.font:                 xft:Hack:Regular:antialias=true:size=9
          Xterm*faceName:             xft:Hack:Regular:antialias=true:size=9
          XTerm*utf8:                 2
          URxvt.letterSpace:          0
          URxvt.background:           #121214
          URxvt.foreground:           #FFFFFF
          XTerm*background:           #121212
          XTerm*foreground:           #FFFFFF
          ! black
          URxvt.color0  :             #2E3436
          URxvt.color8  :             #555753
          XTerm*color0  :             #2E3436
          XTerm*color8  :             #555753
          ! red
          URxvt.color1  :             #CC0000
          URxvt.color9  :             #EF2929
          XTerm*color1  :             #CC0000
          XTerm*color9  :             #EF2929
          ! green
          URxvt.color2  :             #4E9A06
          URxvt.color10 :             #8AE234
          XTerm*color2  :             #4E9A06
          XTerm*color10 :             #8AE234
          ! yellow
          URxvt.color3  :             #C4A000
          URxvt.color11 :             #FCE94F
          XTerm*color3  :             #C4A000
          XTerm*color11 :             #FCE94F
          ! blue
          URxvt.color4  :             #3465A4
          URxvt.color12 :             #729FCF
          XTerm*color4  :             #3465A4
          XTerm*color12 :             #729FCF
          ! magenta
          URxvt.color5  :             #75507B
          URxvt.color13 :             #AD7FA8
          XTerm*color5  :             #75507B
          XTerm*color13 :             #AD7FA8
          ! cyan
          URxvt.color6  :             #06989A
          URxvt.color14 :             #34E2E2
          XTerm*color6  :             #06989A
          XTerm*color14 :             #34E2E2
          ! white
          URxvt.color7  :             #D3D7CF
          URxvt.color15 :             #EEEEEC
          XTerm*color7  :             #D3D7CF
          XTerm*color15 :             #EEEEEC
          URxvt*saveLines:            32767
          XTerm*saveLines:            32767
          URxvt.colorUL:              #AED210
          URxvt.perl-ext:             default,url-select
          URxvt.keysym.M-u:           perl:url-select:select_next
          URxvt.url-select.launcher:  /usr/bin/firefox
          URxvt.url-select.underline: true
          Xft*dpi:                    96
          Xft*antialias:              true
          Xft*hinting:                full
          URxvt.scrollBar:            false
          URxvt*scrollTtyKeypress:    true
          URxvt*scrollTtyOutput:      false
          URxvt*scrollWithBuffer:     false
          URxvt*scrollstyle:          plain
          URxvt*secondaryScroll:      true
          Xft.autohint: 0
          Xft.lcdfilter:  lcddefault
          Xft.hintstyle:  hintfull
          Xft.hinting: 1
          Xft.antialias: 1 
          ! transparent
          URxvt*inheritPixmap: true
          URxvt*.transparent: true
          ! URxvt*.shading: 0 to 99 darkens, 101 to 200 lightens
          URxvt*.shading: 10
       ''}"
    '';
  };

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

  networking.firewall = {
     allowedTCPPorts = [ 27036 27037 ];
     allowedUDPPorts = [ 27031 27036 ];
  };
}
