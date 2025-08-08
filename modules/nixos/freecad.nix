{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # freecad
  ];

}
