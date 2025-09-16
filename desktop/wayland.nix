# desktop/wayland.nix
{ config, pkgs, lib, ... }:

{
  # ===== WAYLAND CORE TOOLS =====
  environment.systemPackages = with pkgs; [
    # Screenshot & recording
    grim
    slurp
    swappy
    wl-clipboard
    
    # Display management
    nwg-displays
    
    # System integration
    xdg-user-dirs
    gsettings-qt
    qtwayland
  ];

  # ===== WAYLAND SPECIFIC SERVICES =====
  services.xserver = {
    enable = false;  # Disable X11
  };

  # ===== POLKIT FOR WAYLAND =====
  security.polkit.enable = true;
  # environment.systemPackages = with pkgs; [
  #   polkit_gnome
  # ];
}
