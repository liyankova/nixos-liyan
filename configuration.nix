{ config, pkgs, ... }:

[
  ./modules/system.nix  # bootloader, core tools, kernel deps, SDDM autologin
  ./modules/gui.nix     # fonts global
  ./modules/dev.nix     # media & utility apps
]

