# Hyprland Keyboard Shortcuts

Custom Hyprland configuration for NixOS with home-manager.

> **Main Modifier Key**: `SUPER` (Windows/Meta key)

---

## Essential Shortcuts (Start Here!)

| Shortcut            | Action                     |
| ------------------- | -------------------------- |
| `SUPER + Return`    | Open terminal (Ghostty)    |
| `SUPER + Space`     | Open app launcher (Walker) |
| `SUPER + Q`         | Close active window        |
| `SUPER + CTRL + L`  | Lock screen                |
| `SUPER + SHIFT + M` | Exit Hyprland              |

---

## Window Management

### Focus Movement (Vim-style)

| Shortcut             | Action                    |
| -------------------- | ------------------------- |
| `SUPER + H`          | Focus window left         |
| `SUPER + J`          | Focus window down         |
| `SUPER + K`          | Focus window up           |
| `SUPER + L`          | Focus window right        |
| `SUPER + Arrow Keys` | Focus window in direction |

### Move Windows

| Shortcut                     | Action                   |
| ---------------------------- | ------------------------ |
| `SUPER + SHIFT + H`          | Move window left         |
| `SUPER + SHIFT + J`          | Move window down         |
| `SUPER + SHIFT + K`          | Move window up           |
| `SUPER + SHIFT + L`          | Move window right        |
| `SUPER + SHIFT + Arrow Keys` | Move window in direction |

### Swap Windows

| Shortcut           | Action                 |
| ------------------ | ---------------------- |
| `SUPER + CTRL + H` | Swap with window left  |
| `SUPER + CTRL + J` | Swap with window down  |
| `SUPER + CTRL + K` | Swap with window up    |
| `SUPER + CTRL + L` | Swap with window right |

### Resize Windows

| Shortcut                   | Action              |
| -------------------------- | ------------------- |
| `SUPER + ALT + H`          | Shrink width        |
| `SUPER + ALT + L`          | Grow width          |
| `SUPER + ALT + K`          | Shrink height       |
| `SUPER + ALT + J`          | Grow height         |
| `SUPER + ALT + Arrow Keys` | Resize in direction |

### Window States

| Shortcut            | Action                               |
| ------------------- | ------------------------------------ |
| `SUPER + F`         | Toggle fullscreen                    |
| `SUPER + SHIFT + F` | Toggle fake fullscreen               |
| `SUPER + V`         | Toggle floating                      |
| `SUPER + P`         | Toggle pseudo-tiling                 |
| `SUPER + T`         | Toggle split direction               |
| `SUPER + Y`         | Pin window (stays on all workspaces) |
| `SUPER + C`         | Center floating window               |

### Mouse Operations

| Shortcut                     | Action        |
| ---------------------------- | ------------- |
| `SUPER + Left Click + Drag`  | Move window   |
| `SUPER + Right Click + Drag` | Resize window |

---

## Workspaces

### Switch Workspaces

| Shortcut              | Action                  |
| --------------------- | ----------------------- |
| `SUPER + 1-9`         | Switch to workspace 1-9 |
| `SUPER + 0`           | Switch to workspace 10  |
| `SUPER + Tab`         | Next workspace          |
| `SUPER + SHIFT + Tab` | Previous workspace      |
| `SUPER + ]`           | Next workspace          |
| `SUPER + [`           | Previous workspace      |

### Move Windows to Workspaces

| Shortcut              | Action                                |
| --------------------- | ------------------------------------- |
| `SUPER + SHIFT + 1-9` | Move window to workspace 1-9 (follow) |
| `SUPER + SHIFT + 0`   | Move window to workspace 10 (follow)  |
| `SUPER + CTRL + 1-9`  | Move window to workspace 1-9 (silent) |
| `SUPER + CTRL + 0`    | Move window to workspace 10 (silent)  |

### Special Workspace (Scratchpad)

| Shortcut            | Action                           |
| ------------------- | -------------------------------- |
| `SUPER + S`         | Toggle special workspace         |
| `SUPER + SHIFT + S` | Move window to special workspace |

---

## Window Cycling

| Shortcut            | Action                   |
| ------------------- | ------------------------ |
| `ALT + Tab`         | Cycle to next window     |
| `ALT + SHIFT + Tab` | Cycle to previous window |

---

## Window Groups

| Shortcut            | Action                   |
| ------------------- | ------------------------ |
| `SUPER + G`         | Toggle group mode        |
| `SUPER + '`         | Next window in group     |
| `SUPER + SHIFT + '` | Previous window in group |

---

## Applications

| Shortcut         | Action                     |
| ---------------- | -------------------------- |
| `SUPER + Return` | Terminal (Ghostty)         |
| `SUPER + Space`  | App launcher (Walker)      |
| `SUPER + D`      | App launcher (alternative) |
| `SUPER + E`      | File manager (Nautilus)    |
| `SUPER + B`      | Browser (Brave)            |
| `SUPER + X`      | Logout menu (wlogout)      |

---

## Screenshots

| Shortcut                | Action                                 |
| ----------------------- | -------------------------------------- |
| `SUPER + SHIFT + S`     | Screenshot region to clipboard         |
| `Print`                 | Screenshot fullscreen to clipboard     |
| `SUPER + Print`         | Screenshot fullscreen and save to file |
| `SUPER + SHIFT + Print` | Screenshot region and edit (Swappy)    |

Screenshots are saved to `~/Pictures/Screenshots/`

---

## Clipboard

| Shortcut            | Action                 |
| ------------------- | ---------------------- |
| `SUPER + SHIFT + V` | Open clipboard history |

---

## Notifications

| Shortcut    | Action                     |
| ----------- | -------------------------- |
| `SUPER + N` | Toggle notification center |

---

## Media Keys

### Volume

| Key                    | Action                 |
| ---------------------- | ---------------------- |
| `XF86AudioRaiseVolume` | Increase volume 5%     |
| `XF86AudioLowerVolume` | Decrease volume 5%     |
| `XF86AudioMute`        | Toggle mute            |
| `XF86AudioMicMute`     | Toggle microphone mute |

### Brightness

| Key                     | Action                 |
| ----------------------- | ---------------------- |
| `XF86MonBrightnessUp`   | Increase brightness 5% |
| `XF86MonBrightnessDown` | Decrease brightness 5% |

### Media Playback

| Key              | Action         |
| ---------------- | -------------- |
| `XF86AudioPlay`  | Play/Pause     |
| `XF86AudioPause` | Play/Pause     |
| `XF86AudioNext`  | Next track     |
| `XF86AudioPrev`  | Previous track |
| `XF86AudioStop`  | Stop playback  |

---

## System

| Shortcut            | Action                 |
| ------------------- | ---------------------- |
| `SUPER + CTRL + L`  | Lock screen (Hyprlock) |
| `SUPER + X`         | Logout menu (wlogout)  |
| `SUPER + SHIFT + M` | Exit Hyprland          |

---

## Quick Reference Card

```
+---------------------------------------------------+
|              HYPRLAND QUICK REFERENCE             |
+---------------------------------------------------+
| SUPER + Return     Terminal                       |
| SUPER + Space      App Launcher                   |
| SUPER + Q          Close Window                   |
| SUPER + CTRL + L   Lock Screen                    |
+---------------------------------------------------+
| SUPER + H/J/K/L    Focus (vim-style)              |
| SUPER + SHIFT + H/J/K/L    Move Window            |
| SUPER + ALT + H/J/K/L      Resize Window          |
+---------------------------------------------------+
| SUPER + 1-9        Switch Workspace               |
| SUPER + SHIFT + 1-9   Move to Workspace           |
| SUPER + Tab        Next Workspace                 |
+---------------------------------------------------+
| SUPER + F          Fullscreen                     |
| SUPER + V          Toggle Float                   |
| SUPER + SHIFT + S  Screenshot Region              |
| SUPER + SHIFT + V  Clipboard History              |
+---------------------------------------------------+
```

---

## Configuration Files

All Hyprland configuration is managed through NixOS/home-manager:

- **System config**: `modules/nixos/hyprland.nix`
- **Hyprland settings**: `modules/home/nixos/hyprland.nix`
- **Waybar**: `modules/home/nixos/waybar.nix`
- **Walker (launcher)**: `modules/home/nixos/walker.nix`
- **Lock screen**: `modules/home/nixos/hyprlock.nix`
- **Idle daemon**: `modules/home/nixos/hypridle.nix`

## Waybar Modules

| Module | Click Action | Right-Click Action |
|--------|--------------|-------------------|
| Bluetooth | Open Blueman Manager | Toggle Bluetooth |
| Network | - | Open Network Editor |
| Audio | Open Pavucontrol | Toggle Mute |
| CPU/Memory | - | Open btop |

To modify keybindings, edit `modules/home/nixos/hyprland.nix` and rebuild:

```bash
sudo nixos-rebuild switch --flake .#desktop
```

---

## Idle Behavior

| Timeout    | Action             |
| ---------- | ------------------ |
| 5 minutes  | Screen dims to 30% |
| 10 minutes | Screen locks       |
| 15 minutes | Display turns off  |

---

## Tips

1. **Vim users**: Navigation is vim-style (H/J/K/L). You'll feel right at home!

2. **Workspaces**: Think of them as virtual desktops. Use `SUPER + 1-9` to switch instantly.

3. **Scratchpad**: `SUPER + S` reveals a hidden workspace for quick tasks. Great for notes, calculators, etc.

4. **Window Groups**: Group related windows together with `SUPER + G`, then cycle through them.

5. **Mouse shortcuts**: Hold `SUPER` and drag with left mouse to move, right mouse to resize.

6. **Clipboard history**: `SUPER + SHIFT + V` shows your clipboard history - no more re-copying!

---

## Troubleshooting

### Screen doesn't lock

- Check if `hyprlock` is installed: `which hyprlock`
- Verify PAM is configured in NixOS

### Waybar not showing

- Check if it's running: `pgrep waybar`
- Restart it: `killall waybar && waybar &`

### No notifications

- Check if swaync is running: `pgrep swaync`
- Toggle notification center: `SUPER + N`

### Volume keys not working

- Ensure `pamixer` is installed
- Check if PipeWire/PulseAudio is running

---


