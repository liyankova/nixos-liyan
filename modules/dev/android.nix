{ config, pkgs, lib, android-nixpkgs, ... }:

let
  androidSdk = android-nixpkgs.sdk.${pkgs.system} (sdkPkgs: with sdkPkgs; [
    cmdline-tools-latest
    build-tools-34-0-0
    platform-tools
    platforms-android-34
    emulator
  ]);
in
{
  environment.systemPackages = with pkgs; [
    androidSdk
    flutter
    android-studio
    jdk17
  ];

  environment.variables = {
    ANDROID_SDK_ROOT = "${androidSdk}";
    ANDROID_HOME     = "${androidSdk}";
    FLUTTER_ROOT     = "${pkgs.flutter}";
  };

  programs.adb.enable = true;
  users.users.liyan.extraGroups = [ "adbusers" "kvm" ];
}
