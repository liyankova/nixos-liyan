{ config, pkgs, lib, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;   # untuk app X11
  };

  # environment vars yang sering dibutuhlu
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };

  # keyboard & touchpad dasar
  services.libinput.enable = true;

  # agar bisa start Hyprland dari TTY
  environment.systemPackages = with pkgs; [
    hyprland
    waybar
    kitty
    rofi
    foot        # terminal minimal wayland-native
    dmenu-wayland
    firefox

  ];
}
