{ config, pkgs, lib, isNixOS ? true, ... }:

{
  # ===== NIX SETTINGS (NixOS specific) =====
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # ===== BASE SYSTEM PACKAGES =====
  environment.systemPackages = with pkgs; [
    # Core utilities
    # curl wget htop git vim neovim tree unzip zip
    # jq duf findutils tree bash zsh bat eza zoxide
    curl wget git htop vim neovim tree unzip zip jq duf findutils bash zsh lsof pciutils
    home-manager mesa-demos
  ];

  # ===== FONTS =====
  fonts.packages = with pkgs; [
    noto-fonts fira-code noto-fonts-cjk-sans
    jetbrains-mono font-awesome terminus_font victor-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fantasque-sans-mono
  ];
  #
  # # ===== SECURITY & PERMISSIONS =====
  # users.users.liyan.extraGroups = [ "wheel" ];
  
  systemd.tmpfiles.rules = [
    "d  /etc/nixos          0775  root  wheel  -  -"
    "d  /etc/nixos/.git      0775  root  wheel  -  -"
  ];
  #
  # # ===== BLUETOOTH =====
  # hardware.bluetooth = {
  #   enable = true;
  #   powerOnBoot = true;
  # };
  # services.blueman.enable = true;
  #
  # # ===== NETWORKING =====
  # networking = {
  #   hostName = "nixos";
  #   networkmanager.enable = true;
  # };
  # time.timeZone = "Asia/Jakarta";
}
