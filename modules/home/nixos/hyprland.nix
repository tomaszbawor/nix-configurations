{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      # ========================================
      # MONITORS
      # ========================================
      monitor = [
        # Default: auto-detect and position automatically
        # Customize for your setup, e.g.:
        # "DP-1, 2560x1440@144, 0x0, 1"
        # "HDMI-A-1, 1920x1080@60, 2560x0, 1"
        ", preferred, auto, 1"
      ];

      # ========================================
      # ENVIRONMENT VARIABLES
      # ========================================
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      # ========================================
      # INPUT
      # ========================================
      input = {
        kb_layout = "pl";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
        };
      };

      # ========================================
      # LOOK AND FEEL
      # ========================================
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        # Tokyo Night inspired colors
        "col.active_border" = "rgba(7aa2f7ee) rgba(bb9af7ee) 45deg";
        "col.inactive_border" = "rgba(414868aa)";

        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = true;
          xray = true;
          ignore_opacity = true;
        };

        shadow = {
          enabled = true;
          range = 30;
          render_power = 3;
          color = "rgba(1a1a2eee)";
        };
      };

      animations = {
        enabled = true;

        # Custom bezier curves
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1.0"
          "quick, 0.15, 0, 0.1, 1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
        smart_split = false;
        smart_resizing = true;
      };

      master = {
        new_status = "master";
        smart_resizing = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vfr = true;
      };

      # ========================================
      # WINDOW RULES
      # ========================================
      windowrulev2 = [
        # Floating windows
        "float, class:^(pavucontrol)$"
        "float, class:^(nm-connection-editor)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(thunar)$"
        "float, class:^(file-roller)$"
        "float, class:^(nwg-displays)$"
        "float, class:^(nwg-look)$"
        "float, class:^(.blueman-manager-wrapped)$"
        "float, class:^(org.gnome.Calculator)$"
        "float, class:^(org.gnome.Settings)$"
        "float, class:^(org.gnome.Nautilus)$"
        "float, class:^(com.github.hluk.copyq)$"
        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"

        # Picture-in-Picture
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "size 640 360, title:^(Picture-in-Picture)$"
        "move 100%-650 100%-370, title:^(Picture-in-Picture)$"

        # Walker (app launcher)
        "float, class:^(walker)$"
        "pin, class:^(walker)$"
        "stayfocused, class:^(walker)$"
        "dimaround, class:^(walker)$"

        # 1Password
        "float, class:^(1Password)$"
        "stayfocused, class:^(1Password)$"
        "dimaround, class:^(1Password)$"

        # Suppress maximize for certain apps
        "suppressevent maximize, class:.*"

        # Idle inhibit for fullscreen
        "idleinhibit fullscreen, class:.*"
        "idleinhibit fullscreen, fullscreen:1"
      ];

      # ========================================
      # LAYER RULES
      # ========================================
      # Note: Layer rules for blur are handled via decoration settings
      # layerrule syntax for blur popups is version-specific

      # ========================================
      # AUTOSTART
      # ========================================
      exec-once = [
        # Portal/DBus environment (required for screen sharing)
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # Authentication agent
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

        # Clipboard manager
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        # Wallpaper (using swww for animated wallpapers, or hyprpaper for static)
        "swww-daemon"

        # Status bar - NOTE: waybar is started via systemd, not here
        # "waybar"

        # Notifications
        "swaync"

        # Idle daemon
        "hypridle"

        # Network applet
        "nm-applet --indicator"

        # Blue light filter (optional - enable for night mode)
        # "wlsunset -l 52.2 -L 21.0"  # Warsaw coordinates
      ];

      # ========================================
      # KEYBINDINGS
      # ========================================
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "nautilus";
      "$menu" = "walker";
      "$browser" = "brave";

      bind = [
        # ----------------------------------------
        # UTILITIES
        # ----------------------------------------
        # Terminal
        "$mainMod, Return, exec, $terminal"

        # App launcher
        "$mainMod, Space, exec, $menu"
        "$mainMod, D, exec, $menu"

        # File manager
        "$mainMod, E, exec, $fileManager"

        # Browser
        "$mainMod, B, exec, $browser"

        # Close window
        "$mainMod, Q, killactive,"

        # Exit Hyprland
        "$mainMod SHIFT, M, exit,"

        # Lock screen (SUPER + CTRL + L to avoid conflict with vim navigation)
        "$mainMod CTRL, L, exec, hyprlock"

        # Logout menu
        "$mainMod, X, exec, wlogout"

        # Toggle floating
        "$mainMod, V, togglefloating,"

        # Pseudo-tiling
        "$mainMod, P, pseudo,"

        # Toggle split (SUPER + T)
        "$mainMod, T, togglesplit,"

        # Fullscreen
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fullscreen, 1"

        # Pin window
        "$mainMod, Y, pin,"

        # Center floating window
        "$mainMod, C, centerwindow,"

        # ----------------------------------------
        # SCREENSHOTS
        # ----------------------------------------
        # Screenshot region to clipboard
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"

        # Screenshot fullscreen to clipboard
        ", Print, exec, grim - | wl-copy"

        # Screenshot region and edit
        "$mainMod SHIFT, Print, exec, grim -g \"$(slurp)\" - | swappy -f -"

        # Screenshot fullscreen and save
        "$mainMod, Print, exec, grim ~/Pictures/Screenshots/$(date +'%Y%m%d_%H%M%S').png"

        # ----------------------------------------
        # CLIPBOARD
        # ----------------------------------------
        "$mainMod SHIFT, V, exec, cliphist list | walker --dmenu | cliphist decode | wl-copy"

        # ----------------------------------------
        # NOTIFICATIONS
        # ----------------------------------------
        "$mainMod, N, exec, swaync-client -t -sw"

        # ----------------------------------------
        # TILING / WINDOW MANAGEMENT
        # ----------------------------------------
        # Move focus (vim-style)
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Move focus (arrow keys)
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move windows (vim-style)
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Move windows (arrow keys)
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # Swap windows
        "$mainMod CTRL, H, swapwindow, l"
        "$mainMod CTRL, L, swapwindow, r"
        "$mainMod CTRL, K, swapwindow, u"
        "$mainMod CTRL, J, swapwindow, d"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Move window to workspace (silent - don't follow)
        "$mainMod CTRL, 1, movetoworkspacesilent, 1"
        "$mainMod CTRL, 2, movetoworkspacesilent, 2"
        "$mainMod CTRL, 3, movetoworkspacesilent, 3"
        "$mainMod CTRL, 4, movetoworkspacesilent, 4"
        "$mainMod CTRL, 5, movetoworkspacesilent, 5"
        "$mainMod CTRL, 6, movetoworkspacesilent, 6"
        "$mainMod CTRL, 7, movetoworkspacesilent, 7"
        "$mainMod CTRL, 8, movetoworkspacesilent, 8"
        "$mainMod CTRL, 9, movetoworkspacesilent, 9"
        "$mainMod CTRL, 0, movetoworkspacesilent, 10"

        # Special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Workspace navigation
        "$mainMod, Tab, workspace, e+1"
        "$mainMod SHIFT, Tab, workspace, e-1"
        "$mainMod, bracketright, workspace, e+1"
        "$mainMod, bracketleft, workspace, e-1"

        # Cycle through windows
        "ALT, Tab, cyclenext,"
        "ALT SHIFT, Tab, cyclenext, prev"

        # Group windows
        "$mainMod, G, togglegroup,"
        "$mainMod, apostrophe, changegroupactive, f"
        "$mainMod SHIFT, apostrophe, changegroupactive, b"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Resize mode bindings (repeating)
      binde = [
        # Resize with vim keys
        "$mainMod ALT, H, resizeactive, -20 0"
        "$mainMod ALT, L, resizeactive, 20 0"
        "$mainMod ALT, K, resizeactive, 0 -20"
        "$mainMod ALT, J, resizeactive, 0 20"

        # Resize with arrow keys
        "$mainMod ALT, left, resizeactive, -20 0"
        "$mainMod ALT, right, resizeactive, 20 0"
        "$mainMod ALT, up, resizeactive, 0 -20"
        "$mainMod ALT, down, resizeactive, 0 20"
      ];

      # ----------------------------------------
      # MEDIA KEYS
      # ----------------------------------------
      bindel = [
        # Volume
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"

        # Brightness
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindl = [
        # Mute
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -t"

        # Media controls
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioStop, exec, playerctl stop"
      ];
    };
  };
}
