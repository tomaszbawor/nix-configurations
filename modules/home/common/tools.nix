{ pkgs, ... }:
{

  home.packages = with pkgs; [
    todoist
    emacs
  ];

}
