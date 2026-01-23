{ pkgs, config, ... }:
{
  # Walker app launcher configuration
  # Walker requires a config directory to function

  xdg.configFile."walker/config.toml".text = ''
    # Walker Configuration - Omarchy Style
    # See: https://github.com/abenz1267/walker

    # Basic settings
    placeholder = "Search..."
    notify_on_fail = true
    show_initial_entries = true
    terminal = "ghostty"
    orientation = "vertical"
    fullscreen = false
    scrollbar_policy = "automatic"
    activation_mode.disabled = false

    [search]
    delay = 0
    force_keyboard_focus = true

    [ui]
    fullscreen = false

    [ui.anchors]
    top = true
    left = true
    right = true
    bottom = false

    [ui.window]
    box.orientation = "vertical"
    box.spacing = 10
    box.h_align = "fill"
    box.v_align = "start"
    h_align = "fill"
    v_align = "start"

    [ui.window.box.scroll]
    h_align = "fill"
    v_align = "fill"
    min_height = 300
    max_height = 400

    [ui.window.box.scroll.list]
    orientation = "vertical"
    spacing = 2
    max_height = 400

    # Styling
    [ui.window.box.margins]
    top = 200
    bottom = 0
    start = 300
    end = 300

    [[modules]]
    name = "applications"
    prefix = ""

    [[modules]]
    name = "runner"
    prefix = ""

    [[modules]]
    name = "websearch"
    prefix = "?"

    [[modules]]
    name = "finder"
    prefix = "/"
  '';

  xdg.configFile."walker/style.css".text = ''
    /* Walker CSS - Tokyo Night Theme */

    * {
      font-family: "Geist Mono", monospace;
      font-size: 14px;
    }

    #window {
      background: rgba(30, 30, 46, 0.95);
      border-radius: 12px;
      border: 2px solid rgba(122, 162, 247, 0.5);
    }

    #box {
      padding: 10px;
    }

    #search {
      background: rgba(69, 71, 90, 0.6);
      border: none;
      border-radius: 8px;
      padding: 12px 16px;
      color: #cdd6f4;
      margin-bottom: 10px;
    }

    #search:focus {
      border: 1px solid rgba(122, 162, 247, 0.8);
    }

    #list {
      background: transparent;
    }

    #item {
      padding: 8px 12px;
      border-radius: 6px;
      margin: 2px 0;
      background: transparent;
      color: #cdd6f4;
    }

    #item:selected {
      background: rgba(122, 162, 247, 0.3);
      color: #ffffff;
    }

    #item:hover {
      background: rgba(122, 162, 247, 0.15);
    }

    #icon {
      margin-right: 10px;
    }

    #text {
      color: #cdd6f4;
    }

    #text:selected {
      color: #ffffff;
    }

    #label {
      color: #6c7086;
      font-size: 12px;
    }
  '';
}
