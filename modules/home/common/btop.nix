{
  pkgs,
  lib,
  system,
  ...
}:
{
  programs.btop = {
    enable = true;
    package =
      if builtins.match ".*-darwin" system != null then
        pkgs.btop # Use standard btop on macOS
      else
        pkgs.btop.override {
          # Only use GPU support overrides on Linux
          rocmSupport = true;
          cudaSupport = true;
        };
    settings = {
      vim_keys = true;
      rounded_corners = true;
      proc_tree = true;
      show_gpu_info = "on";
      show_uptime = true;
      show_coretemp = true;
      cpu_sensor = "auto";
      show_disks = true;
      only_physical = true;
      io_mode = true;
      io_graph_combined = false;
    };
  };
}
