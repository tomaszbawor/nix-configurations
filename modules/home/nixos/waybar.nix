{ pkgs, config, ... }:
{
  # Ensure Nerd Font is available for waybar icons
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    blueman # Bluetooth manager GUI
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        spacing = 4;
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "pulseaudio"
          "bluetooth"
          "network"
          "cpu"
          "memory"
          "battery"
          "custom/notification"
        ];

        # Workspaces
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
            urgent = "󰗖";
            active = "󰝥";
            default = "󰝦";
          };
          on-click = "activate";
          sort-by-number = true;
          all-outputs = true;
        };

        # Window title
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };

        # Clock
        clock = {
          interval = 1;
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃭 {:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'>{}</span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        # CPU
        cpu = {
          interval = 2;
          format = "󰍛 {usage}%";
          format-alt = "󰍛 {avg_frequency}GHz";
          tooltip = true;
          tooltip-format = "CPU: {usage}%";
          on-click-right = "ghostty -e btop";
        };

        # Memory
        memory = {
          interval = 10;
          format = "󰾆 {percentage}%";
          format-alt = "󰾆 {used:0.1f}G";
          tooltip = true;
          tooltip-format = "RAM: {used:0.1f}GB / {total:0.1f}GB";
          on-click-right = "ghostty -e btop";
        };

        # Battery
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-full = "󰁹 Full";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-time = "{H}h {M}min";
          tooltip = true;
          tooltip-format = "{timeTo} | {power}W";
        };

        # Bluetooth
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-off = "󰂲";
          format-connected = "󰂱 {num_connections}";
          format-connected-battery = "󰂱 {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
          on-click-right = "bluetoothctl power toggle";
        };

        # Network
        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰌘 {ipaddr}";
          format-linked = "󰈁 {ifname}";
          format-disconnected = "󰌙 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}";
          tooltip-format-ethernet = "{ifname}\n{ipaddr}";
          tooltip-format-disconnected = "Disconnected";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          on-click-right = "nm-connection-editor";
        };

        # Audio
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "󰂰 {volume}%";
          format-bluetooth-muted = "󰂲 {icon}";
          format-muted = "󰖁";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰏲";
            car = "󰄋";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
          on-click-right = "pamixer -t";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          tooltip-format = "{icon} {desc} | {volume}%";
        };

        # System tray
        tray = {
          icon-size = 18;
          spacing = 8;
        };

        # Notifications
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "󰂚";
            none = "󰂜";
            dnd-notification = "󰂛";
            dnd-none = "󰪑";
            inhibited-notification = "󰂛";
            inhibited-none = "󰂜";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "JetBrainsMono NF", monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.85);
        border-radius: 10px;
        color: #cdd6f4;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      tooltip {
        background: rgba(30, 30, 46, 0.9);
        border: 1px solid #7aa2f7;
        border-radius: 8px;
      }

      tooltip label {
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 8px;
        color: #6c7086;
        background: transparent;
        border: none;
        border-radius: 6px;
        margin: 3px 2px;
        transition: all 0.3s ease;
      }

      #workspaces button:hover {
        background: rgba(122, 162, 247, 0.2);
        color: #7aa2f7;
      }

      #workspaces button.active {
        background: #7aa2f7;
        color: #1e1e2e;
        font-weight: bold;
      }

      #workspaces button.urgent {
        background: #f38ba8;
        color: #1e1e2e;
      }

      #window {
        padding: 0 10px;
        color: #cdd6f4;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #bluetooth,
      #pulseaudio,
      #tray,
      #custom-notification {
        padding: 0 10px;
        margin: 3px 2px;
        border-radius: 6px;
        background: rgba(69, 71, 90, 0.4);
        color: #cdd6f4;
      }

      #clock {
        font-weight: bold;
        color: #7aa2f7;
      }

      #battery {
        color: #a6e3a1;
      }

      #battery.charging,
      #battery.plugged {
        color: #a6e3a1;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical:not(.charging) {
        background-color: #f38ba8;
        color: #1e1e2e;
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #1e1e2e;
        }
      }

      #cpu {
        color: #89b4fa;
      }

      #memory {
        color: #cba6f7;
      }

      #network {
        color: #94e2d5;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #bluetooth {
        color: #89b4fa;
      }

      #bluetooth.disabled,
      #bluetooth.off {
        color: #6c7086;
      }

      #bluetooth.connected {
        color: #a6e3a1;
      }

      #pulseaudio {
        color: #f9e2af;
      }

      #pulseaudio.muted {
        color: #6c7086;
      }

      #tray {
        margin-right: 5px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #f38ba8;
      }

      #custom-notification {
        color: #f9e2af;
      }
    '';
  };
}
