{ pkgs, ... }:
{

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";
    mouse = true;
    baseIndex = 1;

    newSession = true;
    # fixing tmux-escape crazy behaviour
    escapeTime = 0;

    secureSocket = false;
    historyLimit = 50000;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.tmux-powerline
    ];

    extraConfig = ''
      # Plugins
      set -g @tmux_powerline_theme 'default'   # or 'solarized', etc.

      # Change Windows as in Vim 
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Intuitive Splits
      bind | split-window -h
      bind - split-window -v
      unbind "
      unbind %
    '';
  };

}
