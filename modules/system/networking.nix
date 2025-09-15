{ config, lib, pkgs, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  time.timeZone = "Asia/Jakarta";
}
