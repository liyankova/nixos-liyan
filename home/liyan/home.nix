# home/home.nix
{ config, pkgs, lib, ... }:

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

  home.username = config.username;
  home.homeDirectory = config.homeDirectory;
  home.stateVersion = config.stateVersion;
  
  programs.home-manager.enable = true;


}
