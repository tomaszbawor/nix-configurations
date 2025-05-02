{ pkgs, username, ... }:
{

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages_6_14;

  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.xserver.xkb = {
    # Keyboard layout
    layout = "pl";
    variant = "";
  };

  programs.fish.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "Tomasz Bawor";
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.fish;
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-24.11";
  };

  programs = {
    nix-ld.enable = true; # Enable nix-ld
  };

}
