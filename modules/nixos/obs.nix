{
  pkgs,
  lib,
  username,
  ...
}:
{
  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins =
      (with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-gstreamer
        obs-vkcapture
        obs-teleport
        obs-shaderfilter
        advanced-scene-switcher
        pixel-art
        input-overlay
      ])
      ++ lib.optionals (pkgs.obs-studio-plugins ? obs-websocket) (
        with pkgs.obs-studio-plugins;
        [
          # OBS WebSocket enables remote control/automation (Stream Deck, scripts).
          # Note: OBS Studio 28+ ships WebSocket built-in, so this is only needed
          # if the plugin is provided by nixpkgs.
          obs-websocket
        ]
      );
  };

}
