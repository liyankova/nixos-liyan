# desktop/hyprland.nix
{ config, pkgs, lib, ... }:

{
  # ===== HYPRLAND WINDOW MANAGER =====
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  # ===== WAYLAND ENVIRONMENT VARIABLES =====
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };

  # ===== INPUT DEVICES =====
  services.libinput.enable = true;

  # ===== XDG PORTALS =====
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # ===== SYSTEM PACKAGES (Essential only) =====
  environment.systemPackages = with pkgs; [
    hyprland
    waybar
    dmenu-wayland
  ];
}
