# home/shell.nix
{ config, pkgs, lib, ... }:

{
  # ===== ZSH CONFIGURATION =====
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    # Oh-my-zsh with minimal plugins
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
    
    syntaxHighlighting.enable = true;
    # autosuggestions.enable = true;
  };

  programs.zoxide.enable = true;

  # ===== SHELL PACKAGES =====
  home.packages = with pkgs; [
    fzf
    oh-my-posh
    # exa
    bat

    zoxide
    git
    vim
    neovim
  ];

  # ===== SHELL ENVIRONMENT =====
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # ===== ZSH CONFIG =====
  # programs.zsh.initExtra = ''
  #   eval "$(zoxide init zsh)"
  #
  #   # Oh-my-posh (if theme exists)
  #   if [ -f ~/.config/oh-my-posh/theme.omp.json ]; then
  #     eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/theme.omp.json)"
  #   fi
  #
  #   # FZF
  #   if [ -n "${"$"}{commands[fzf-share]}" ]; then
  #     source "$(fzf-share)/key-bindings.zsh"
  #     source "$(fzf-share)/completion.zsh"
  #   fi
  # '';

  # ===== GIT CONFIG =====
  programs.git = {
    enable = true;
    userName = "liyan";
    userEmail = "liyannkova@example.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
