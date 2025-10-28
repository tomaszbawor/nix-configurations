{ pkgs, username, ... }:
{

  programs.zsh.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "Tomasz Bawor";
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };

}
