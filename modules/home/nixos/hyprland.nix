{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fuzzel
  ];

  home.file.".config/hypr/hyprland.conf".text = ''
    $mod = SUPER
    $terminal = ghostty
    $lock = hyprlock

    exec-once = systemctl --user start noctalia-shell.service
    exec-once = hypridle

    input {
      kb_layout = pl
    }

    bind = $mod SHIFT, slash, exec, sh -c "hyprctl binds | fuzzel --dmenu --prompt 'Hyprland Binds'"

    bind = $mod, T, exec, $terminal
    bind = $mod, space, exec, noctalia-shell ipc call launcher toggle
    bind = $mod ALT, L, exec, $lock
    bind = $mod, N, exec, noctalia-shell ipc call controlCenter toggle

    bind = $mod ALT, S, exec, sh -c "pkill orca || exec orca"

    bindl = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0
    bindl = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-
    bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioStop, exec, playerctl stop
    bindl = , XF86AudioPrev, exec, playerctl previous
    bindl = , XF86AudioNext, exec, playerctl next

    bindel = , XF86MonBrightnessUp, exec, brightnessctl --class=backlight set +10%
    bindel = , XF86MonBrightnessDown, exec, brightnessctl --class=backlight set 10%-

    bind = $mod, O, togglespecialworkspace, overview
    bind = $mod, Q, killactive

    bind = $mod, left, movefocus, l
    bind = $mod, down, movefocus, d
    bind = $mod, up, movefocus, u
    bind = $mod, right, movefocus, r
    bind = $mod, H, movefocus, l
    bind = $mod, J, movefocus, d
    bind = $mod, K, movefocus, u
    bind = $mod, L, movefocus, r

    bind = $mod CTRL, left, movewindow, l
    bind = $mod CTRL, down, movewindow, d
    bind = $mod CTRL, up, movewindow, u
    bind = $mod CTRL, right, movewindow, r
    bind = $mod CTRL, H, movewindow, l
    bind = $mod CTRL, J, movewindow, d
    bind = $mod CTRL, K, movewindow, u
    bind = $mod CTRL, L, movewindow, r

    bind = $mod SHIFT, left, focusmonitor, l
    bind = $mod SHIFT, down, focusmonitor, d
    bind = $mod SHIFT, up, focusmonitor, u
    bind = $mod SHIFT, right, focusmonitor, r
    bind = $mod SHIFT, H, focusmonitor, l
    bind = $mod SHIFT, J, focusmonitor, d
    bind = $mod SHIFT, K, focusmonitor, u
    bind = $mod SHIFT, L, focusmonitor, r

    bind = $mod, Page_Down, workspace, e+1
    bind = $mod, Page_Up, workspace, e-1
    bind = $mod, U, workspace, e+1
    bind = $mod, I, workspace, e-1

    bind = $mod CTRL, Page_Down, movetoworkspacesilent, e+1
    bind = $mod CTRL, Page_Up, movetoworkspacesilent, e-1
    bind = $mod CTRL, U, movetoworkspacesilent, e+1
    bind = $mod CTRL, I, movetoworkspacesilent, e-1

    bind = $mod SHIFT, Page_Down, movetoworkspace, e+1
    bind = $mod SHIFT, Page_Up, movetoworkspace, e-1
    bind = $mod SHIFT, U, movetoworkspace, e+1
    bind = $mod SHIFT, I, movetoworkspace, e-1

    bind = $mod, mouse_down, workspace, e+1
    bind = $mod, mouse_up, workspace, e-1

    bind = $mod, 1, workspace, 1
    bind = $mod, 2, workspace, 2
    bind = $mod, 3, workspace, 3
    bind = $mod, 4, workspace, 4
    bind = $mod, 5, workspace, 5
    bind = $mod, 6, workspace, 6
    bind = $mod, 7, workspace, 7
    bind = $mod, 8, workspace, 8
    bind = $mod, 9, workspace, 9

    bind = $mod CTRL, 1, movetoworkspacesilent, 1
    bind = $mod CTRL, 2, movetoworkspacesilent, 2
    bind = $mod CTRL, 3, movetoworkspacesilent, 3
    bind = $mod CTRL, 4, movetoworkspacesilent, 4
    bind = $mod CTRL, 5, movetoworkspacesilent, 5
    bind = $mod CTRL, 6, movetoworkspacesilent, 6
    bind = $mod CTRL, 7, movetoworkspacesilent, 7
    bind = $mod CTRL, 8, movetoworkspacesilent, 8
    bind = $mod CTRL, 9, movetoworkspacesilent, 9

    bind = $mod, R, togglesplit
    bind = $mod, F, fullscreen
    bind = $mod SHIFT, F, fullscreen, 1

    bind = $mod, C, centerwindow

    bind = $mod, minus, resizeactive, -10 0
    bind = $mod, equal, resizeactive, 10 0
    bind = $mod SHIFT, minus, resizeactive, 0 -10
    bind = $mod SHIFT, equal, resizeactive, 0 10

    bind = $mod, V, togglefloating

    bind = , Print, exec, sh -c "grim - | wl-copy"
    bind = CTRL, Print, exec, sh -c "mkdir -p \"$HOME/Pictures/Screenshots\" && grim \"$HOME/Pictures/Screenshots/$(date +%F_%H-%M-%S).png\""
    bind = ALT, Print, exec, sh -c "grim -g \"$(slurp)\" - | wl-copy"

    bind = $mod SHIFT, E, exit
    bind = CTRL ALT, Delete, exit

    bind = $mod SHIFT, P, exec, hyprctl dispatch dpms off
  '';

  home.file.".config/hypr/hypridle.conf".text = ''
    general {
      lock_cmd = hyprlock
      before_sleep_cmd = hyprlock
      after_sleep_cmd = hyprctl dispatch dpms on
    }

    listener {
      timeout = 600
      on-timeout = hyprlock
    }

    listener {
      timeout = 900
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }
  '';

  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
      color = rgba(0, 0, 0, 1.0)
    }

    input-field {
      size = 300, 60
      outline_thickness = 2
      rounding = 10
      dots_size = 0.33
      dots_spacing = 0.2
      fade_on_empty = true
      placeholder_text = "Password"
      position = 0, -40
      halign = center
      valign = center
    }
  '';
}
