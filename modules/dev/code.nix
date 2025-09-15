{ config, pkgs, lib, ... }:

let
  # VS Code dengan ekstensi pre-download (unofficial)
  vscode-with-ext = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      ms-vscode.vscode-typescript-next        # JS/TS
      rust-lang.rust-analyzer
      golang.go
      dart-code.flutter
      dart-code.dart-code
      pkgs.vscode-extensions.mkhl.direnv      # opsional
    ] ++ lib.optional pkgs.stdenv.isLinux pkgs.vscode-extensions.ms-vscode.vscode-json;
  };
in
{
  environment.systemPackages = with pkgs; [
    # === Core editor ==================================================
    vscode-with-ext

    # === Rust toolchain ===============================================
    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer          # LSP
    pkg-config
    openssl
    gcc                    # linker

    # === Go toolchain =================================================
    go
    gopls                  # LSP
    gotools                # goimports, godoc, dll
    delve                  # debugger

    # === JS/TS + Node =================================================
    nodejs_20              # LTS
    nodePackages.pnpm
    nodePackages.npm
    nodePackages.yarn
    nodePackages.typescript
    nodePackages.ts-node
    nodePackages.prettier
    nodePackages.eslint

    # === Flutter ======================================================
    flutter                # channel stable
    android-studio         # SDK Manager GUI (opsional)
    cmdline-tools          # tanpa GUI
  ];

  # === Flutter config (tanpa Android Studio) ==========================
  programs.flutter = {
    enable = true;
    # channel bisa "stable", "beta", "dev"
    channel = "stable";
  };

  # === Android SDK ====================================================
  programs.android-sdk = {
    enable = true;
    platformTools = true;
    cmdlineTools = true;
    buildTools = [ "34.0.0" ];   # sesuaikan
    platforms = [ "34" ];        # API 34
    abiVersions = [ "arm64-v8a" "x86_64" ];
  };

  # Supaya Flutter menemukan Android SDK -------------------------------
  environment.variables = {
    ANDROID_SDK_ROOT = "${config.programs.android-sdk.sdkRoot}";
    ANDROID_HOME = "${config.programs.android-sdk.sdkRoot}";
    FLUTTER_ROOT = "${pkgs.flutter}";
  };

  # === direnv (opsional, project-level env) ===========================
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;   # integrasi flakes
}
