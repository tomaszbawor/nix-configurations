{ pkgs, ... }:
{

  programs.ghostty = {
    enable = true;
    # Only install the package on Linux; on macOS it's installed via Homebrew
    package = if pkgs.stdenv.isLinux then pkgs.ghostty else null;
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
