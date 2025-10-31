{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      font-awesome
      fira-code
      fira-code-symbols
      nerd-fonts.jetbrains-mono
    ];
  };
}
