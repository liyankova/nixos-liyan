{ config, pkgs, lib, ... }:
{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "nowatchdog"
    "modprobe.blacklist=iTCO_wdt"
  ];

  # Power
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  # Nix optimisations
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Session vars
#  environment.sessionVariables = {
#    NIXOS_OZONE_WL = "1";
#    QT_QPA_PLATFORM = "wayland";
#    MOZ_ENABLE_WAYLAND = "1";
#  };
}
