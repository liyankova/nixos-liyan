# home/apps.nix
{ config, pkgs, lib, ... }:

{
  # ===== PERSONAL APPLICATIONS =====
  home.packages = with pkgs; [
    # Media & Entertainment
    spotify
    vlc
    mpv
    yt-dlp
    ffmpeg
    
    # Productivity
    obsidian
    firefox
    
    # Creative
    krita
    gimp
    inkscape
    
    # Communication
    discord
    slack
    teams
    zoom-us
    
    # System Tools
    obsidian
    baobab
    btop
    cava
    inxi
    duf

        wallust
    swww
    swaynotificationcenter
    rofi
    wlogout
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
    brightnessctl
    nwg-look
    xarchiver
    yad
    unzip
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
    findutils
    killall
    libappindicator
    libnotify
    pay-respects
    bat
    bc
    gtk-engine-murrine
    imagemagick
    jq
    loupe
    polkit_gnome
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtwayland
    networkmanagerapplet
    nwg-displays
    nwg-look
    playerctl
    nvtopPackages.full
  ];

  # ===== APPLICATION CONFIGURATIONS =====
  programs.firefox = {
    enable = true;
    # Firefox settings bisa ditambah di sini
  };

  # programs.vlc = {
  #   enable = true;
  # };
}
