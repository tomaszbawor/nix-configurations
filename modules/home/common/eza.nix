{ ... }:
{

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    extraOptions = [
      "--icons"
      "--git"
    ];
  };

}
