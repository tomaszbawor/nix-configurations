{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ollama-cuda
  ];
}
