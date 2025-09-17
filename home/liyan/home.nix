{ config, pkgs, lib, isNixOS ? false, vars, ... }:

{
  imports = [
    ./vars.nix
    ../../nix/home-modules/shell.nix
    ../../nix/home-modules/dev.nix
    ../../nix/home-modules/android-home.nix
    ../../nix/home-modules/apps.nix
  ] ++ lib.optionals isNixOS [
    ../../nix/home-modules/wayland-tools.nix
    ../../nix/home-modules/systemd-services.nix
  ];

  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;
  home.stateVersion = vars.stateVersion;
  
  programs.home-manager.enable = true;


}
