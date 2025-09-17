# desktop/wayland.nix
{ config, pkgs, lib, ... }:

{

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
