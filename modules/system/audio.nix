{ config, pkgs, lib, ... }:

let
  python-packages = pkgs.python3.withPackages (ps: with ps; [
    requests
    pyquery   # untuk weather script hyprland-dots
  ]);
in
{
  # matikan pulseaudio lama
  services.pulseaudio.enable = false;  # nyalain PipeWire + WirePlumber
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;   # compat layer untuk app PulseAudio
    wireplumber.enable = true;
  };

  # tambah tools
  environment.systemPackages = with pkgs; [
    wireplumber
    pipewire
    pamixer        # CLI volume
    pavucontrol    # GUI volume (optional)
    brightnessctl
    python-packages
  ];
}
