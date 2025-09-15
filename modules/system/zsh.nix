{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
#      theme = "robbyrussell";
      plugins = [ "git" "sudo" ];   # fzf tidak perlu lagi, kita bind manual
    };
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    # autoCompletion = true;
  };

  programs.zoxide.enable = true;

  environment.systemPackages = with pkgs; [
    go
    fzf
    oh-my-posh
  ];

  # programs.fzf.enable = true;   # otomatis source file yang benar
  environment.etc."zshrc-go".text = "${pkgs.go}/share/go";
  # .zshrc global – include fzf + omz + posh
  # environment.etc."zsh/zshrc".text = ''
  #   # oh-my-posh prompt (arahkan ke tema kamu)
  #   eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/wallust.om.json)"
  #
  #   # zoxide
  #   eval "$(zoxide init zsh)"
  #
  #   # fzf key-bindings & completion
  #   if [ -n "${"$"}{commands[fzf-share]}" ]; then
  #     source "$(fzf-share)/key-bindings.zsh"
  #     source "$(fzf-share)/completion.zsh"
  #   fi
  # '';
}
