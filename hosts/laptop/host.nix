{ config, pkgs, lib, vars, ... }:
{
  # Declare custom options
  options = {
    enableNvidia = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA driver";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "Hostname of the machine";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Asia/Jakarta";
      description = "System timezone";
    };
    swapDevice = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Swap device UUID";
    };
    sudoNoPassword = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Allow sudo without password for wheel group";
    };
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "25.05";
      description = "NixOS state version";
    };
  };

  # Configuration assignments

    imports = [
      ./vars.nix
      ./hardware-configuration.nix
      ../../nix/modules/shared/core.nix
      ../../nix/modules/nixos/system/boot.nix
      ../../nix/modules/nixos/system/audio.nix
      ../../nix/modules/nixos/android/system.nix
      ../../nix/modules/shared/shell.nix
      ../../nix/modules/nixos/desktop/hyprland.nix
      ../../nix/modules/nixos/desktop/wayland.nix
      ../../nix/modules/nixos/desktop/steam.nix
      ../../nix/modules/nixos/networking/networking.nix
      ../../nix/modules/nixos/system/nvidia.nix
    ];
  config = {
    nixpkgs.config.allowUnsupportedSystem = true;
    programs.zsh.enable = true;

    users.users.${vars.username or "liyan"} = {
      isNormalUser = true;
      description = "Liyan";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
      shell = pkgs.zsh;
    };

    swapDevices = lib.optionals (vars.swapDevice != "") [{
      device = vars.swapDevice;
    }];

    security.sudo.wheelNeedsPassword = lib.mkIf vars.sudoNoPassword false;
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_6;  # Force LTS 6.6
    boot.initrd.preDeviceCommands = "echo 'blacklist nouveau' > /etc/modprobe.d/blacklist-nouveau.conf";  # Early blacklist
    # Set config values from vars
    networking.hostName = vars.hostName or "laptop";
    time.timeZone = vars.timeZone or "Asia/Jakarta";
    enableNvidia = vars.enableNvidia or false;
    sudoNoPassword = vars.sudoNoPassword or false;
    system.stateVersion = vars.stateVersion or "25.05";
  };
}
