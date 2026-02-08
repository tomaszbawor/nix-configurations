{ pkgs, username, ... }:
{

  programs.zsh.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "Tomasz Bawor";
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
      "wireshark"

      # Streaming / capture / HW accel helpers
      "video" # V4L2 devices (capture cards) and some OBS/virtual-cam setups
      "render" # access to DRM render nodes (helps certain HW-accel paths)
      "audio" # legacy group; can help with some audio device access edge cases

      # Security tradeoff: grants access to raw input devices (/dev/input). Only
      # keep if you actually use input overlays / capture tools that require it.
      "input"
    ];
    shell = pkgs.zsh;
  };

}
