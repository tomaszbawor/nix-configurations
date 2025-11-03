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
      catppuccin
      cpu
      battery
      vim-tmux-navigator # Using ctrl-j k l h for switch windows
    ];

    extraConfig = ''
      # Terminal setup (Neovim is crying about them)
      set-option -g default-terminal "tmux-256color"
      set-option -g status-position top
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "rounded"

      # Make the status line pretty and add some modules
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      # set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
      # set -agF status-right "#{E:@catppuccin_status_battery}"

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
