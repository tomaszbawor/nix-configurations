{ profile, ... }:
{
  # PipeWire benefits from realtime scheduling under load (OBS + browser + builds),
  # which reduces crackles/xruns and helps keep A/V sync stable.
  security.rtkit.enable = true;

  # Services to start
  services = {
    libinput.enable = true; # Input Handling
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    openssh.enable = true; # Enable SSH
    blueman.enable = true; # Bluetooth Support
    tumbler.enable = true; # Image/video preview
    gnome.gnome-keyring.enable = true;

    smartd = {
      enable = true;
      autodetect = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # Be explicit about the PipeWire session manager to avoid regressions when
      # defaults change between releases (important for streaming workflows).
      wireplumber.enable = true;
    };
  };
}
