{ pkgs, config, ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        grace = 5;
        hide_cursor = true;
        no_fade_in = false;
        no_fade_out = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.6;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          size = "250, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          dots_rounding = -1;
          outer_color = "rgba(122, 162, 247, 0.8)";
          inner_color = "rgba(30, 30, 46, 0.9)";
          font_color = "rgb(205, 214, 244)";
          fade_on_empty = false;
          fade_timeout = 1000;
          placeholder_text = "<i><span foreground=\"##cdd6f4\">Password...</span></i>";
          hide_input = false;
          rounding = 10;
          check_color = "rgba(166, 227, 161, 0.8)";
          fail_color = "rgba(243, 139, 168, 0.8)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 300;
          capslock_color = "rgba(249, 226, 175, 0.8)";
          numlock_color = -1;
          bothlock_color = -1;
          invert_numlock = false;

          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Time
        {
          text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
          color = "rgba(205, 214, 244, 1.0)";
          font_size = 120;
          font_family = "Geist Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(205, 214, 244, 0.8)";
          font_size = 24;
          font_family = "Geist Mono";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        # User greeting
        {
          text = "Hi, $USER";
          color = "rgba(122, 162, 247, 1.0)";
          font_size = 18;
          font_family = "Geist Mono";
          position = "0, -30";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
