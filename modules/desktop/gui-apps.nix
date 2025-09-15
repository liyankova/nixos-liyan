{ config, lib, pkgs, ... }:

with lib;
let
  # list paket GUI besar; tambah/hapus sesuka mu
  guiPkgs = with pkgs; [
    spotify
    obsidian
    krita
    gimp
    inkscape
    vlc
    discord
    slack
    teams
    zoom-us
    vscode
#    cursor
    gemini-cli
#    claude-desktop
    # flatpak-run  # <-- baru dipakai bila ada app yang benar-benar tidak ada di nixpkgs
  ];
in
{
  options.my.gui-apps.enable = mkEnableOption "GUI desktop applications";

  config = mkIf config.my.gui-apps.enable {
    environment.systemPackages = guiPkgs;
  };
}
