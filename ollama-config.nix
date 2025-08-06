{ pkgs, ... }:

{
  programs.ollama = {
    enable = true;
    package = pkgs.ollama;
    settings = {
      # ...
    };
  };
}
