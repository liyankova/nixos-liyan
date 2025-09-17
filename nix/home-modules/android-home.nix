# home/android.nix  
{ config, pkgs, lib, ... }:

let
  # Android SDK akan di-handle di system level untuk NixOS
  # Tapi kita bisa setup environment variables dan tools
in
{
  # ===== ANDROID ENVIRONMENT =====
  home.sessionVariables = {
    # These will be overridden by system config on NixOS
    # But useful for other OS
    ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Android/Sdk";
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
    FLUTTER_ROOT = "${pkgs.flutter}";
    JAVA_HOME = "${pkgs.jdk17.home}";
  };

  # ===== ANDROID CONFIGURATION =====
  home.file.".android".source = pkgs.writeTextDir "android-tools.cfg" ''
    # Android development configuration
    sdk.root=${config.home.homeDirectory}/Android/Sdk
    flutter.sdk=${pkgs.flutter}
    java.home=${pkgs.jdk17.home}
  '';

  # ===== FLUTTER CONFIG =====
  home.file.".flutter-settings".text = ''
    {
      "android-studio-dir": "${pkgs.android-studio}/lib/android-studio",
      "jdk-dir": "${pkgs.jdk17.home}"
    }
  '';
}
