{ pkgs, ... }:
{

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
    baseIndex = 1;
    tmuxinator.enable = true;

    newSession = true;
    # fixing tmux-escape crazy behaviour
    escapeTime = 0;

    secureSocket = false;
    historyLimit = 50000;
    # sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      nord
      cpu
      battery
      vim-tmux-navigator # Using ctrl-j k l h for switch windows
    ];

    extraConfig = ''
      # Terminal setup (Neovim is crying about them)
      set-option -g default-terminal "tmux-256color"

      # Make the status line pretty and add some modules
      set-option -g status-position top
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""

      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Change Windows as in Vim 
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Intuitive Splits
      bind | split-window -h
      bind - split-window -v
    '';
  };

}
