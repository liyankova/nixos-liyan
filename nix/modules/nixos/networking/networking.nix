{ config, pkgs, lib, isNixOS ? true, ... }:
{
  networking = lib.mkIf isNixOS {
    hostName = config.hostName or "nixos";
    networkmanager.enable = true;
  };
  time.timeZone = config.timeZone or "Asia/Jakarta";
  hardware.bluetooth = lib.mkIf isNixOS {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = lib.mkIf isNixOS true;
}
