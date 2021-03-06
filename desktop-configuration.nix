
{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in
{
  boot.kernelPackages = unstable.linuxPackages_5_4;
  boot.kernelParams = [
    "ivrs_ioapic[4]=00:14.0"
    "ivrs_ioapic[5]=00:00.2"
  ];
  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root 08C8-EFF8
          chainloader /efi/Microsoft/Boot/bootmgfw.efi
        }
      '';
      version = 2;
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.extraConfig = "
    [General]
    Enable=Source,Sink,Control,Media,Socket
  ";
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };
}
