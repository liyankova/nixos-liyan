# system/boot.nix
{ config, lib, pkgs, ... }:

{
  # ===== BOOT LOADER (NixOS Only) =====
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  # ===== KERNEL & PERFORMANCE =====
  # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_6;
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "nowatchdog"
    "modprobe.blacklist=iTCO_wdt"  
  ];

  # ===== NIX OPTIMIZATIONS =====
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # ===== POWER MANAGEMENT =====
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  # ===== INPUT DEVICES =====
  services.libinput.enable = true;

  # ===== DISPLAY MANAGER =====
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "hyprland";
  };
}
