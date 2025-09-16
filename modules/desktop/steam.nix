{ config, pkgs, lib, ... }:

{
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Additional packages for gaming
  environment.systemPackages = with pkgs; [
#    gamemode
    mangohud
    goverlay
    wine
    winetricks
  ];

  # Enable gamemode for performance optimization
#  services.gamemode.enable = true;

  # Add user to necessary groups
  users.users.liyan.extraGroups = [ "games" "video" ];
}
