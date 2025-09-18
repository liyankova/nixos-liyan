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

    # Set config values from vars
    networking.hostName = vars.hostName or "laptop";
    time.timeZone = vars.timeZone or "Asia/Jakarta";
    enableNvidia = vars.enableNvidia or false;
    sudoNoPassword = vars.sudoNoPassword or false;
    system.stateVersion = vars.stateVersion or "25.05";
  };
}

# { config, pkgs, lib, ... }:
#
# {
#   imports = [
#  #   ./hardware.nix
#     ./hardware-configuration.nix
#     # system
#     ../../nix/modules/system/boot.nix
#     ../../nix/modules/system/audio.nix
#     ../../nix/modules/system/nvidia.nix
#     ../../nix/modules/android/system.nix
#
#     # core
#     ../../nix/modules/core/core.nix
#
#     # shell
#     ../../nix/modules/shell/system.nix
#
#     # desktop
#     ../../nix/modules/desktop/hyprland.nix
#     ../../nix/modules/desktop/wayland.nix
#     ../../nix/modules/desktop/steam.nix
#     # ../../nix/modules/desktop/xdg-portals.nix
#
#   ];
#   # my.gui-apps.enable = true; 
#   nixpkgs.config.allowUnsupportedSystem = true; 
#   programs.zsh.enable = true;
#   # User
#   users.users.liyan = {
#     isNormalUser = true;
#     description = "Liyan";
#     extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
#     shell = pkgs.zsh;
#   };
#
#
#
#
#   # Swap (sesuaikan UUID kamu)
#   swapDevices = [{
#     device = "/dev/disk/by-uuid/3efb9b12-ba2a-47e0-b11e-bef00b43577e";
#   }];
#   # Sudo no-password (opsional)
#   security.sudo.wheelNeedsPassword = false;
#   system.stateVersion = "25.05";
# }
#
