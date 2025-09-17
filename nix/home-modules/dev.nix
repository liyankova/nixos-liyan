# home/dev.nix
{ config, pkgs, lib, ... }:

{
  # ===== EDITORS =====
  programs.vscode = {
    enable = true;
	#    package = pkgs.vscode-with-extensions.override {
	#      vscodeExtensions = with pkgs.vscode-extensions; [
	#        rust-lang.rust-analyzer
	#        golang.go
	# #        ms-vscode.vscode-typescript-next
	# # pname
	#      ];
	#    };
    
    # VS Code user settings
    profiles.default.userSettings = {
      "editor.fontSize" = 14;
      "editor.fontFamily" = "JetBrains Mono, monospace";
      "workbench.colorTheme" = "Default Dark+";
      # "rust-analyzer.cargo.allFeatures" = true;
      # "go.formatTool" = "gofmt";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    # Basic neovim config
    # extraConfig = ''
    #   set number
    #   set relativenumber 
    #   set tabstop=2
    #   set shiftwidth=2
    #   set expandtab
    #   set smartindent
    #   set mouse=a
    # '';
    
    # Plugins bisa ditambah nanti
    plugins = with pkgs.vimPlugins; [ ];
  };

  # ===== DEVELOPMENT LANGUAGES =====
  home.packages = with pkgs; [

    # (vscode-with-extensions.override {
    #   vscodeExtensions = with vscode-extensions; [
    #     rust-lang.rust-analyzer
    #     golang.go
    #   ];
    # })
    # Rust toolchain
    cargo rustc rustfmt clippy rust-analyzer

    # Go
    go gopls gotools delve

    # Node.js (v20 attribute)
    nodejs_20
    # If you want pnpm/npm helpers: use nodePackages.pnpm or pnpm via npm wrapper in your devshells.

    # Build helpers / common libs
    pkg-config openssl


    # Android / mobile dev (keep in home so it works on non-NixOS)
    flutter android-studio jdk17
    ];

  # ===== DEVELOPMENT ENVIRONMENT =====
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # programs.git = {
  #   enable = true;
  #   userName = "liyan";
  #   userEmail = "liyannkova@example.com";
  #   extraConfig = {
  #     init.defaultBranch = "main";
  #     pull.rebase = true;
  #     push.autoSetupRemote = true;
  #     # "core.editor" = "nvim";
  #   };
  # };

  # ===== ENVIRONMENT VARIABLES =====
  home.sessionVariables = {
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
    GOPATH = "${config.home.homeDirectory}/go";
    NODE_ENV = "development";
  };
}
