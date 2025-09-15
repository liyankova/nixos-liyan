{ config, pkgs, lib, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts fira-code noto-fonts-cjk-sans
      jetbrains-mono font-awesome terminus_font victor-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.fantasque-sans-mono
    ];
  };
}
