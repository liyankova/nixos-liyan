{ config, pkgs, lib, ... }:

let
  # VS Code + ekstensi
  vscode-with-ext = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      ms-vscode.vscode-typescript-next   # JS/TS
      rust-lang.rust-analyzer            # Rust
      golang.go                          # Go
      dart-code.flutter                  # Flutter
      dart-code.dart-code
    ];
  };

  # Android SDK versi 34 (bisa ganti sesuka mu)
  androidSdk = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "34" ];
    abiVersions      = [ "arm64-v8a" "x86_64" ];
    buildToolsVersions = [ "34.0.0" ];
    includeNDK = false;   # true kalau butuh native
  };

in
{
  environment.systemPackages = with pkgs; [
    # === Core editor ================================================
    vscode-with-ext

    # === Rust ========================================================
    cargo rustc rustfmt clippy rust-analyzer pkg-config openssl

    # === Go ==========================================================
    go gopls gotools delve

    # === JS/TS =======================================================
    nodejs_20 nodePackages.pnpm nodePackages.npm nodePackages.yarn
    nodePackages.typescript nodePackages.ts-node
    nodePackages.prettier nodePackages.eslint

    # === Flutter + Android (low-level) ===============================
    flutter
    androidSdk.platform-tools
    androidSdk.build-tools-34-0-0
    androidSdk.platforms.android-34
    jdk17          # dibutuhkan Flutter & Android
  ];

  # === Flutter paths ================================================
  environment.variables = {
    ANDROID_SDK_ROOT = "${androidSdk.sdkRoot}";
    ANDROID_HOME     = "${androidSdk.sdkRoot}";
    FLUTTER_ROOT     = "${pkgs.flutter}";
  };

  # === ADB untuk device / emulator ==================================
  programs.adb.enable = true;
  users.users.liyan.extraGroups = [ "adbusers" "kvm" ];

  # === direnv (opsional) ============================================
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
