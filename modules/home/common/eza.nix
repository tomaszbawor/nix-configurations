{ ... }:
{

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraOptions = [
      "--icons"
      "--git"
    ];
  };

}
