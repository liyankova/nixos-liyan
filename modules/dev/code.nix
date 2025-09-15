{ config, pkgs, lib, ... }:

let
  vscode-with-ext = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      ms-vscode.vscode-typescript-next
      rust-lang.rust-analyzer
      golang.go
      dart-code.flutter
      dart-code.dart-code
    ];
  };

  androidSdk = pkgs.androidenv.composeAndroidPackages {
    platformVersions   = [ "34" ];
    abiVersions        = [ "arm64-v8a" "x86_64" ];
    buildToolsVersions = [ "34.0.0" ];
    includeNDK         = false;
  };

  # Flatten semua output androidSdk menjadi list datar
  androidPkgs = with androidSdk; [
    platform-tools
    build-tools
  ] ++ lib.flatten (lib.attrValues platforms)
    ++ lib.optionals includeNDK ndk-bundle;

in
{
  environment.systemPackages = with pkgs; [
    vscode-with-ext

    # Rust
    cargo rustc rustfmt clippy rust-analyzer pkg-config openssl

    # Go
    go gopls gotools delve

    # JS/TS
    nodejs_20 nodePackages.pnpm nodePackages.npm nodePackages.yarn
    nodePackages.typescript nodePackages.ts-node
    nodePackages.prettier nodePackages.eslint

    # Flutter + Android (flatten)
    flutter
    jdk17
  ] ++ androidPkgs;

  environment.variables = {
    ANDROID_SDK_ROOT = "${androidSdk.sdkRoot}";
    ANDROID_HOME     = "${androidSdk.sdkRoot}";
    FLUTTER_ROOT     = "${pkgs.flutter}";
  };

  programs.adb.enable = true;
  users.users.liyan.extraGroups = [ "adbusers" "kvm" ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
