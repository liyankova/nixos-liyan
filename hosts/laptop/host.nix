{ config, pkgs, lib, ... }:

{
  imports = [
 #   ./hardware.nix
    ./hardware-configuration.nix
    # # system
    # ../../system/boot.nix
    # ../../nix/modules/system/system-core.nix
    # ../../system/audio.nix
    # ../../system/nvidia.nix
    # ../../nix/modules/system/android-system.nix
    #
    #
    # # desktop
    # ../../desktop/hyprland.nix   # ← Baru
    # ../../desktop/wayland.nix    # ← Baru
    # ../../desktop/steam.nix      # ← Baru
    # # ../../nix/modules/system/shell-system.nix

    # system
    ../../nix/modules/system/boot.nix
    ../../nix/modules/system/system-core.nix
    ../../nix/modules/system/audio.nix
    ../../nix/modules/system/nvidia.nix
    ../../nix/modules/system/android-system.nix

    # desktop
    ../../nix/modules/desktop/hyprland.nix
    ../../nix/modules/desktop/wayland.nix
    ../../nix/modules/desktop/steam.nix
    ../../nix/modules/desktop/xdg-portals.nix

  ];
  # my.gui-apps.enable = true; 
  nixpkgs.config.allowUnsupportedSystem = true; 
  programs.zsh.enable = true;
  # User
  users.users.liyan = {
    isNormalUser = true;
    description = "Liyan";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
    shell = pkgs.zsh;
  };

  # Packages dasar


  # Swap (sesuaikan UUID kamu)
  swapDevices = [{
    device = "/dev/disk/by-uuid/3efb9b12-ba2a-47e0-b11e-bef00b43577e";
  }];

  # Disable X dulu (nanti baru nyalain Hyprland)
  #services.xserver.enable = false;

  # Audio
  # sound.enable = true;
  #services.pulseaudio.enable = true;
  # Sudo no-password (opsional)
  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "25.05";
}

