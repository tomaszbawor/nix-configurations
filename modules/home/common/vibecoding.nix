{
  pkgs,
  inputs,
  ...
}:
let
  goosePackage = inputs.goose;
in
{
  home.packages = [
    pkgs.claude-code
    pkgs.codex
    goosePackage.defaultPackage.${pkgs.system}
    # goose-jki
  ];

}
