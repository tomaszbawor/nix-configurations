{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    # Declarative configuration written to ~/.config/noctalia/*.json.
    # See upstream defaults: Assets/settings-default.json.
    settings = {
      colorSchemes = {
        useWallpaperColors = false;
        darkMode = true;
      };
    };

    # Auto-configure the plugin source registry. Individual plugin enablement
    # can still be managed via Noctalia UI (it writes plugin state).
    plugins = {
      version = 1;
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
    };

    # Green neon / Matrix-like palette.
    colors = {
      mPrimary = "#00FF41";
      mOnPrimary = "#001B0B";
      mSecondary = "#00CC33";
      mOnSecondary = "#001B0B";
      mTertiary = "#7CFF9E";
      mOnTertiary = "#001B0B";

      mSurface = "#050A06";
      mOnSurface = "#B7FFCF";
      mSurfaceVariant = "#0B1A0F";
      mOnSurfaceVariant = "#7CFF9E";

      mOutline = "#1C4D2E";
      mShadow = "#000000";

      mError = "#FF3344";
      mOnError = "#111111";
    };
  };
}
