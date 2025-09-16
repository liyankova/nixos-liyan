# home/default.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./shell.nix
    # ./dev.nix
    # ./apps.nix
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
