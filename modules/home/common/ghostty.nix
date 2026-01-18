{ pkgs, ... }:
{

  programs.ghostty = {
    enable = true;
    # Only install the package on Linux; on macOS it's installed via Homebrew
    package = if pkgs.stdenv.isLinux then pkgs.ghostty else null;
    enableZshIntegration = true;
    settings = {
      font-family = "Geist Mono";
      font-size = 16;
      background-opacity = 0.85;
      unfocused-split-opacity = 0.9;
    };
  };

  # Ensure the Nerd Font is installed
  home.packages = with pkgs; [
    nerd-fonts.geist-mono
  ];

}
