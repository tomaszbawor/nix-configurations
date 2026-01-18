{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.claude-code
    pkgs.codex
    pkgs.opencode
    pkgs.lmstudio
  ];

}
