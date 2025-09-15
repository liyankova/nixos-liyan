{ config, pkgs, lib, ... }:

let
  # VS Code + ekstensi web-dev
  vscode-with-ext = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
#      ms-vscode.vscode-typescript-next   # JS/TS
      rust-lang.rust-analyzer            # Rust
      golang.go                          # Go
    ];
  };
in
{
  environment.systemPackages = with pkgs; [
    vscode-with-ext

    # === Rust =========================================================
    cargo rustc rustfmt clippy rust-analyzer pkg-config openssl

    # === Go ===========================================================
    go gopls gotools delve

    # === JS/TS ========================================================
    nodejs_20 nodePackages.pnpm nodePackages.npm nodePackages.yarn
    nodePackages.typescript nodePackages.ts-node
    nodePackages.prettier nodePackages.eslint
  ];

  # === direnv (opsional) =============================================
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
