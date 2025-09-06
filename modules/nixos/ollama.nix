{
  pkgs,
  ...
}:
{
  #environment.systemPackages = with pkgs; [
  # ollama-cuda
  #];

  # services.ollama = {
  #   enable = true;
  #   acceleration = "cuda";
  #   loadModels = [
  #     "gemma3:12b"
  #     "deepseek-r1:14b"
  #   ];
  # };
  #
  # services.open-webui = {
  #   enable = true;
  #   port = 1234;
  # };
  #
  # services.n8n = {
  #   enable = true;
  #   openFirewall = true;
  # };

}
