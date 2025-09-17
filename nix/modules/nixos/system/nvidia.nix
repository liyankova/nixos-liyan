{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = lib.mkIf config.enableNvidia true;

  hardware.graphics = lib.mkIf config.enableNvidia {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = lib.mkIf config.enableNvidia [ "nvidia" ];

  hardware.nvidia = lib.mkIf config.enableNvidia {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  boot.kernelModules = lib.mkIf config.enableNvidia [ "nvidia" ];
  boot.extraModulePackages = lib.mkIf config.enableNvidia [ config.boot.kernelPackages.nvidia_x11 ];
}

# # system/nvidia.nix
# { config, pkgs, lib, ... }:
#
# {
#   # ===== NVIDIA SETUP (NixOS specific) =====
#   nixpkgs.config.allowUnfree = true;
#
#   hardware.graphics = {
#     enable = true;
#     enable32Bit = true;
#   };
#
#   services.xserver.videoDrivers = [ "nvidia" ];
#
#   hardware.nvidia = {
#     modesetting.enable = true;
#     powerManagement.enable = true;
#     powerManagement.finegrained = false;
#     open = false;
#     nvidiaSettings = true;
#     package = config.boot.kernelPackages.nvidiaPackages.stable;
#
#     prime = {
#       sync.enable = true;
#       intelBusId = "PCI:0:2:0";
#       nvidiaBusId = "PCI:1:0:0";
#     };
#   };
#
#   boot.kernelModules = [ "nvidia" ];
#   boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
# }
