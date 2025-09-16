# desktop/steam.nix
{ config, pkgs, lib, ... }:

{
  # ===== STEAM SETUP =====
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # ===== GAMING TOOLS =====
  environment.systemPackages = with pkgs; [
    mangohud
    goverlay
    wine
    winetricks
  ];

  # ===== USER GROUPS =====
  users.users.liyan.extraGroups = [ "games" "video" ];
}
