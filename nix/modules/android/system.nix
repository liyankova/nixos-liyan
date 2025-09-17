# system/android.nix
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
  # ===== ANDROID SYSTEM PACKAGES =====
  environment.systemPackages = with pkgs; [
    androidSdk
  ];

  # ===== ANDROID ENVIRONMENT VARIABLES =====
  environment.variables = {
    ANDROID_SDK_ROOT = "${androidSdk}";
    ANDROID_HOME = "${androidSdk}";
  };

  # ===== ANDROID SYSTEM CONFIG =====
  programs.adb.enable = true;
  users.users.liyan.extraGroups = [ "adbusers" "kvm" ];
}
