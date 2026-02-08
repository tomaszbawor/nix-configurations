{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    enableZshIntegration = true;
    enableInteractive = true;

    settings = {
      # Starship scans the current directory to detect context (git repo, etc.).
      # On slow/remote mounts or very large directories this can time out and
      # print warnings on every prompt render.
      scan_timeout = 200;
    };
  };
}
