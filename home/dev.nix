# home/dev.nix
{ config, pkgs, lib, ... }:

{
  # ===== EDITORS =====
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        golang.go
        ms-vscode.vscode-typescript-next
      ];
    };
    
    # VS Code user settings
    userSettings = {
      "editor.fontSize" = 14;
      "editor.fontFamily" = "JetBrains Mono, monospace";
      "workbench.colorTheme" = "Default Dark+";
      "rust-analyzer.cargo.allFeatures" = true;
      "go.formatTool" = "gofmt";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    # Basic neovim config
    extraConfig = ''
      set number
      set relativenumber 
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent
      set mouse=a
    '';
    
    # Plugins bisa ditambah nanti
    plugins = with pkgs.vimPlugins; [ ];
  };

  # ===== DEVELOPMENT LANGUAGES =====
  home.packages = with pkgs; [
    # Rust
    cargo 
    rustc 
    rustfmt 
    clippy 
    rust-analyzer
    pkg-config
    openssl
    
    # Go
    go
    gopls
    gotools
    delve
    
    # Node.js/TypeScript
    nodejs_20
    nodePackages.pnpm
    nodePackages.npm
    nodePackages.yarn
    nodePackages.typescript
    nodePackages.ts-node
    nodePackages.prettier
    nodePackages.eslint
    
    # Development tools
    direnv
    git
  ];

  # ===== DEVELOPMENT ENVIRONMENT =====
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "liyan";
    userEmail = "your-email@example.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      "core.editor" = "nvim";
    };
  };

  # ===== ENVIRONMENT VARIABLES =====
  home.sessionVariables = {
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
    GOPATH = "${config.home.homeDirectory}/go";
    NODE_ENV = "development";
  };
}
