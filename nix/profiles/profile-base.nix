{ config, pkgs, ... }:

[
  # ./modules/system.nix  # bootloader, core tools, kernel deps, SDDM autologin
  # ./modules/gui.nix     # fonts global
  # ./modules/dev.nix     # media & utility apps


  ../modules/system/system-core.nix  # bootloader, core tools, kernel deps
  ../modules/system/audio.nix        # audio config
  ../modules/system/nvidia.nix       # nvidia config

]

