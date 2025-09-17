{ config, pkgs, lib, isNixOS ? true, vars, ... }:
{
  networking = lib.mkIf isNixOS {
    hostName = vars.hostName or "nixos";
    networkmanager.enable = true;
  };
  time.timeZone = vars.timeZone or "Asia/Jakarta";
  hardware.bluetooth = lib.mkIf isNixOS {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = lib.mkIf isNixOS true;
}
