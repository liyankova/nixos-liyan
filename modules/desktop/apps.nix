{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    git.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        exo mousepad thunar-archive-plugin thunar-volman tumbler
      ];
    };
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    xwayland.enable = true;
  };

  # Portal extras
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # App & tools
  environment.systemPackages = with pkgs; [
    bc btop brightnessctl cava cliphist grim gtk-engine-murrine
    hypridle imagemagick inxi jq kitty libsForQt5.qtstyleplugin-kvantum
    loupe networkmanagerapplet nwg-displays nwg-look nvtopPackages.full
    playerctl polkit_gnome libsForQt5.qt5ct kdePackages.qt6ct
    kdePackages.qtwayland rofi slurp swappy
    swaynotificationcenter swww unzip wallust wl-clipboard wlogout
    xarchiver yad yt-dlp
    fastfetch mpv glib gsettings-qt openssl pciutils xdg-user-dirs
    baobab btrfs-progs clang cpufrequtils curl duf ffmpeg findutils
    git killall libappindicator libnotify vim wget neovim pay-respects bat
  ];
}
