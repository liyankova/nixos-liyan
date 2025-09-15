{ config, pkgs, lib, inputs, ... }:

let
  # SDK Android (channel stable) ------------------------------------
  androidSdk = inputs.android-nixpkgs.packages.${pkgs.system}.sdk (sdk: with sdk; [
    cmdline-tools-latest
    build-tools-34-0-0
    platform-tools
    platforms-android-34
    emulator
  ]);

in
{
  environment.systemPackages = with pkgs; [
    androidSdk                      # SDK + platform-tools
    flutter                         # stable channel
    android-studio                  # GUI IDE
    jdk17                           # JDK untuk Studio & Flutter
  ];

  # Supaya Studio & Flutter menemukan SDK ---------------------------
  environment.variables = {
    ANDROID_SDK_ROOT = "${androidSdk}";
    ANDROID_HOME     = "${androidSdk}";
    FLUTTER_ROOT     = "${pkgs.flutter}";
  };

  # ADB + KVM untuk emulator ----------------------------------------
  programs.adb.enable = true;
  users.users.liyan.extraGroups = [ "adbusers" "kvm" ];
}
