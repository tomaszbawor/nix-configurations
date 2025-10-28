{ pkgs, ... }:
{

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
    baseIndex = 1;

    newSession = true;
    # fixing tmux-escape crazy behaviour
    escapeTime = 0;

    secureSocket = false;
    historyLimit = 50000;
    sensibleOnTop = true;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.tmux-fzf # Fuzzy Find in TMUX
      tmuxPlugins.vim-tmux-navigator # Using ctrl-j k l h for switch windows
      tmuxPlugins.catppuccin
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

      # Theme
      set -g @catppuccin_window_text \"#W\"
      set -g @catppuccin_status_modules_right "date_time battery directory session"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_text "#W"
      set -g @catppuccin_window_current_text "#W"

      set -g status-position top
      set -g window-status-current-style fg=red,bg=black
      set -g status-interval 1
      set -g status-left-length 100
      set -g status-left ""
    '';
  };

}
