{ config, pkgs, lib, ... }:
{
  # Display manager
#  services.xserver = {
#    enable = true;          # butuh X untuk SDDM
#    displayManager.sddm = {
#      enable = true;
#      autoLogin = {
#        enable = true;
#        user = "liyan";
#      };
#      wayland.enable = true; # SDDM pakai Wayland backend
#    };
#  };
  services.libinput.enable = true;
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true; # SDDM pakai Wayland backend
    
  };

  # Pastikan SDDM bisa start Hyprland
  services.displayManager.defaultSession = "hyprland";
}
