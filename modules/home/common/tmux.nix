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
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      tmux-fzf # Fuzzy Find in TMUX
      vim-tmux-navigator # Using ctrl-j k l h for switch windows
    ];

    extraConfig = ''
      # Terminal setup (Neovim is crying about them)
      set-option -g default-terminal "screen-256color"
      set-option -a terminal-features 'XXX:RGB'

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

      # --- Status bar ---
      set -g status-position top
      set -g status-bg colour235
      set -g status-fg colour245
      set -g status-interval 5
      set -g status-left-length 40
      set -g status-right-length 120

      set -g status-left "#[fg=colour39,bold]#S #[fg=colour240]| #[fg=colour39]#I:#P"
      set -g status-right "#[fg=colour244]%Y-%m-%d #[fg=colour245]%H:%M #[fg=colour39]#(whoami)"

      # --- Window title style ---
      setw -g window-status-current-format " #[fg=colour39,bold]#I:#W#[default] "
      setw -g window-status-format " #[fg=colour244]#I:#W#[default] "

      set -g status-position top
      set -g window-status-current-style fg=red,bg=black
      set -g status-interval 1
      set -g status-left-length 100
      set -g status-left ""
    '';
  };

}
