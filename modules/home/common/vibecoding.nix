{
  pkgs,
  inputs,
  ...
}:{
  home.packages = [
    pkgs.claude-code
    pkgs.codex
  ];

}
