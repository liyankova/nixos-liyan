{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
    ./hardware-configuration.nix

    # boot
    ../../modules/boot/grub.nix
    ../../modules/boot/sddm.nix
    ../../modules/boot/opt.nix

    # system
    ../../modules/system/networking.nix
    ../../modules/system/nix-settings.nix
    ../../modules/system/audio.nix
    ../../modules/system/fonts.nix
    ../../modules/system/zsh.nix
    ../../modules/system/bt.nix
    ../../modules/system/nvidia.nix

    # desktop
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/apps.nix
    ../../modules/desktop/gui-apps.nix
    ../../modules/desktop/hypr.nix
#    ../../modules/desktop/steam.nix

    # dev
    ../../modules/dev/code.nix
    ../../modules/dev/android.nix

  ];
  my.gui-apps.enable = true; 
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
  environment.systemPackages = with pkgs; [
    vim git htop wget curl unzip zsh neovim tree bash

  ];

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

