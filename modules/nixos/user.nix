{ pkgs, username, ... }:
{

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

}
