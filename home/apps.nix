# home/apps.nix
{ config, pkgs, lib, ... }:

{
  # ===== PERSONAL APPLICATIONS =====
  home.packages = with pkgs; [
    # Media & Entertainment
    spotify
    vlc
    mpv
    yt-dlp
    
    # Productivity
    obsidian
    firefox
    
    # Creative
    krita
    gimp
    inkscape
    
    # Communication
    discord
    slack
    teams
    zoom-us
    
    # System Tools
    obsidian
    baobab
    btop
    cava
    inxi
    duf
  ];

  # ===== APPLICATION CONFIGURATIONS =====
  programs.firefox = {
    enable = true;
    # Firefox settings bisa ditambah di sini
  };

  programs.vlc = {
    enable = true;
  };
}
