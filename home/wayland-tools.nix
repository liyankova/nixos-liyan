# home/wayland-tools.nix
{ config, pkgs, lib, ... }:

{
  # ===== WAYLAND USER TOOLS =====
  home.packages = with pkgs; [
    # Terminal emulators
    kitty
    foot
    
    # Launcher
    rofi
    wlogout
    
    # Notification
    swaynotificationcenter
    
    # Wallpaper
    swww
    
    # Screen capture
    grim
    slurp
    swappy
    
    # Clipboard
    wl-clipboard
    cliphist
    
    # Display tools
    nwg-look
    brightnessctl
    
    # Audio visual
    cava
    
    # File manager
    thunar
  ];

  # ===== THUNAR CONFIGURATION =====
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
  };

  # ===== USER SERVICES =====
  services.gpg-agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;
  programs.seahorse.enable = true;
  
  # Fuse untuk user mounts
  programs.fuse.userAllowOther = true;
}
