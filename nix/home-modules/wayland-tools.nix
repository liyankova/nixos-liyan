# home/wayland-tools.nix
{ config, pkgs, lib, ... }:

{
  # ===== WAYLAND USER TOOLS =====
  home.packages = with pkgs; [
  
    # terminals / launchers
    kitty foot rofi

    # Wayland screenshot/clipboard/selection + compositing helpers
    grim slurp swappy wl-clipboard cliphist

    # Wallpapers / theme / look
    swww wallust nwg-look

    # Notifications / logout
    swaynotificationcenter wlogout

    # Display / brightness / tray
    nwg-displays brightnessctl networkmanagerapplet playerctl

    # XFCE helpers (optional, for file manager / utilities)
    xfce.thunar xfce.exo xfce.mousepad xfce.thunar-archive-plugin xfce.tumbler

    # Qt styling helpers (if you use Qt apps under Wayland)
    libsForQt5.qtstyleplugin-kvantum libsForQt5.qt5ct kdePackages.qt6ct libsForQt5.qtwayland

    cava glib gsettings-qt clang cpufrequtils
  ];

  # ===== THUNAR CONFIGURATION =====
  # programs.thunar = {
  #   enable = true;
  #   plugins = with pkgs.xfce; [
  #     exo
  #     mousepad
  #     thunar-archive-plugin
  #     thunar-volman
  #     tumbler
  #   ];
  # };

  # ===== USER SERVICES =====
  services.gpg-agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  # DConf & Seahorse - fix config
  # programs.seahorse.enable = true;
  
  # Fuse - fix deprecated
  # programs.fuse = {
  #   enable = true;
  #   userAllowOther = true;
  # };

  # MTR - tambahkan
  # programs.mtr.enable = true;
}
