# home/home.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ../../nix/home-modules/shell-home.nix
    ../../nix/home-modules/dev.nix
    ../../nix/home-modules/android-home.nix
    ../../nix/home-modules/apps.nix
    ../../nix/home-modules/wayland-tools.nix
    ../../nix/home-modules/systemd-services.nix
  ];

  # Basic home setup
  home.username = "liyan";
  home.homeDirectory = "/home/liyan";
  home.stateVersion = "25.05";
  
  programs.home-manager.enable = true;

  # Global home packages
  home.packages = with pkgs; [
    # Your existing tools
    fastfetch
    mpv
    yt-dlp
  ];
}
