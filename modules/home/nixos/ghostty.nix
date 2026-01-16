{ pkgs, ... }:
{

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "Iosevka Nerd Font";
      font-size = 12;
      background-opacity = 0.85;
      unfocused-split-opacity = 0.9;
    };
  };

  # Ensure the Nerd Font is installed
  home.packages = with pkgs; [
    nerd-fonts.iosevka
  ];

}
