{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
           nixpkgs.config.nvidia.acceptLicense = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

services.xserver.videoDrivers = lib.mkForce [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.legacy_470;
    prime = {
      # sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" ];
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.initrd.kernelModules = [ "nvidia" ];  # Load NVIDIA early
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
}

# { config, pkgs, lib, ... }:
# {
#   nixpkgs.config.allowUnfree = lib.mkIf config.enableNvidia true;
#
#   hardware.graphics = lib.mkIf config.enableNvidia {
#     enable = true;
#     enable32Bit = true;
#   };
#
#   services.xserver.videoDrivers = lib.mkIf config.enableNvidia [ "nvidia" ];
#
#   hardware.nvidia = lib.mkIf config.enableNvidia {
#     modesetting.enable = true;
#     powerManagement.enable = true;
#     powerManagement.finegrained = false;
#     open = false;
#     nvidiaSettings = true;
#     package = config.boot.kernelPackages.nvidiaPackages.stable;
#     prime = {
#       sync.enable = true;
#       intelBusId = "PCI:0:2:0";
#       nvidiaBusId = "PCI:1:0:0";
#     };
#   };
#
#   boot.kernelModules = lib.mkIf config.enableNvidia [ "nvidia" ];
#   boot.extraModulePackages = lib.mkIf config.enableNvidia [ config.boot.kernelPackages.nvidia_x11 ];
# }
#
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
