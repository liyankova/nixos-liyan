# home/systemd-services.nix
{ config, pkgs, lib, ... }:

{
  # ===== HYPRLAND USER SERVICES =====
  systemd.user.services.hypr-shebang = {
  Unit = {
    Description = "Fix shebangs and make Hyprland scripts executable";
    After = [ "graphical-session.target" ];
  };

  Install = {
    WantedBy = [ "graphical-session.target" ];
  };

    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeScript "fix-shebang" ''
        #!${pkgs.bash}/bin/bash
        if [ -d /home/liyan/.config/hypr/scripts ]; then
          find /home/liyan/.config/hypr/scripts -type f -exec \
            sed -i '1s|#!/bin/bash|#!/usr/bin/env bash|' {} +
	    chmod +x /home/liyan/.config/hypr/scripts/*
        fi
        if [ -d /home/liyan/.config/hypr/UserScripts ]; then
          find /home/liyan/.config/hypr/UserScripts -type f -exec \
            sed -i '1s|#!/bin/bash|#!/usr/bin/env bash|' {} +
            chmod +x /home/liyan/.config/hypr/UserScripts/*
        fi
      '';
    };
  };
}
