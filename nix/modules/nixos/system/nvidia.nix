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
  boot = {
    blacklistedKernelModules = [ "nouveau" "nvidiafb" ];
    kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    extraModprobeConfig = "options nvidia_drm fbdev=1";
  };
  # boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" ];
  # blacklistedKernelModules = [ "nouveau" "nvidiafb" ];
  # kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  # initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];  # Load early
  # extraModprobeConfig = "options nvidia_drm fbdev=1";  # Force modeset
}
