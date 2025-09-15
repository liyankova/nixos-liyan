{ config, lib, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  users.users.liyan.extraGroups = [ "wheel" ];
  systemd.tmpfiles.rules = [
    "d  /etc/nixos          0775  root  wheel  -  -"
    "d  /etc/nixos/.git      0775  root  wheel  -  -"
  ];
}
