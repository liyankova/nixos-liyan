# home/apps.nix
{ config, pkgs, lib, ... }:

{
  # ===== PERSONAL APPLICATIONS =====
  home.packages = with pkgs; [
  

    # Media & playback
    mpv vlc ffmpeg yt-dlp spotify

    # Productivity / notes / browser
    obsidian firefox

    # Creative
    krita gimp inkscape loupe imagemagick

    # Communication (desktop clients)
    discord slack teams-for-linux zoom-us

    # File / disk / monitor
    baobab btop inxi duf nvtopPackages.full

    # Utilities (user-facing)
    xarchiver yad unzip jq bat bc

    # Integration & desktop libs (keep user-level helpers here)
    libnotify libappindicator polkit_gnome xdg-user-dirs

    # Misc small tools (non-shell-specific)
    fastfetch pay-respects

    # NOTE: terminal-focused tools like fzf / zoxide / eza / oh-my-posh
    # are kept in nix/home-modules/shell.nix (to avoid duplicate installs)


     # # Media & Entertainment
    # spotify
    # vlc
    # mpv
    # yt-dlp
    # ffmpeg
    #
    # # Productivity
    # obsidian
    # firefox
    #
    # # Creative
    # krita
    # gimp
    # inkscape
    #
    # # Communication
    # discord
    # slack
    # teams
    # zoom-us
    #
    # # System Tools
    # obsidian
    # baobab
    # btop
    # cava
    # inxi
    # duf
    #
    #     wallust
    # swww
    # swaynotificationcenter
    # rofi
    # wlogout
    # grim
    # slurp
    # swappy
    # wl-clipboard
    # cliphist
    # brightnessctl
    # nwg-look
    # xarchiver
    # yad
    # unzip
    # fastfetch
    # glib
    # gsettings-qt
    # openssl
    # pciutils
    # xdg-user-dirs
    # btrfs-progs
    # clang
    # cpufrequtils
    # curl
    # findutils
    # killall
    # libappindicator
    # libnotify
    # pay-respects
    # bat
    # bc
    # gtk-engine-murrine
    # imagemagick
    # jq
    # loupe
    # polkit_gnome
    # libsForQt5.qtstyleplugin-kvantum
    # libsForQt5.qt5ct
    # kdePackages.qt6ct
    # libsForQt5.qtwayland
    # networkmanagerapplet
    # nwg-displays
    # nwg-look
    # playerctl
    # nvtopPackages.full
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
