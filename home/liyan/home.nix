{ config, pkgs, lib, dotfiles, ... }:

{
  home.username = "liyan";
  home.homeDirectory = "/home/liyan";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # home.file = lib.mkMerge (
  #   map (name: {
  #     ".config/${name}" = {
  #       source = "${dotfiles}/.config/${name}";
  #       recursive = true;
  #     };
  #   }) (builtins.attrNames (builtins.readDir "${dotfiles}/.config"))
  # );

  programs.zsh = {
    enable = true;
    # initExtra = ''
    #   eval "$(zoxide init zsh)"
    #   eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/wallust.om.json)"
    #   if [ -n "${"$"}{commands[fzf-share]}" ]; then
    #     source "$(fzf-share)/key-bindings.zsh"
    #     source "$(fzf-share)/completion.zsh"
    #   fi
    # '';
    dotfile.enable = false;
  };

  home.packages = with pkgs; [
    fzf zoxide oh-my-posh
  ];
}
