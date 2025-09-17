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


  ];

  # ===== APPLICATION CONFIGURATIONS =====
  programs.firefox = {
    enable = true;
  };

}
