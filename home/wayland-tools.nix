# home/wayland-tools.nix
{ config, pkgs, lib, ... }:

{
  # ===== WAYLAND USER TOOLS =====
  home.packages = with pkgs; [
    # Terminal emulators
    kitty
    foot
    
    # Launcher
    rofi
    wlogout
    
    # Notification
    swaynotificationcenter
    
    # Wallpaper
    swww
    
    # Screen capture
    grim
    slurp
    swappy
    
    # Clipboard
    wl-clipboard
    cliphist
    
    # Display tools
    nwg-look
    brightnessctl
    
    # Audio visual
    cava
        xfce.thunar
    xfce.exo
    xfce.mousepad
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.tumbler
    
    # Qt theming - fix qt packages
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtwayland
    
    # System tools
    baobab
    btop
    inxi
    duf
    nvtopPackages.full
    
    # Media
    vlc
    mpv
    
    # Utilities
    xarchiver
    yad
    unzip
    wl-clipboard
    wlogout
    networkmanagerapplet
    nwg-displays
    nwg-look
    playerctl
    
    # Missing from old config
    bc
    brightnessctl
    gtk-engine-murrine
    imagemagick
    jq
    loupe
    polkit_gnome
    fastfetch
    glib
    gsettings-qt
    openssl
    pciutils
    xdg-user-dirs
    btrfs-progs
    clang
    cpufrequtils
    curl
    ffmpeg
    findutils
    killall
    libappindicator
    libnotify
    pay-respects
    bat
    # File manager
    # thunar
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
  # programs.dconf.enable = true;
  # programs.seahorse.enable = true;
  
  # Fuse - fix deprecated
  # programs.fuse = {
  #   enable = true;
  #   userAllowOther = true;
  # };

  # MTR - tambahkan
  # programs.mtr.enable = true;
}
