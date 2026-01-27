# Niri Keyboard Shortcuts

This document lists the default Niri keybindings from the upstream
`default-config.kdl`. If you customize your binds, update this file
to match your local `~/.config/niri/config.kdl`.

Source reference:
- https://raw.githubusercontent.com/YaLTeR/niri/master/resources/default-config.kdl

## Essentials

| Shortcut | Action |
| --- | --- |
| Mod + Shift + / | Show hotkey overlay |
| Mod + T | Terminal (default: alacritty) |
| Mod + D | App launcher (default: fuzzel) |
| Super + Alt + L | Lock screen (default: swaylock) |
| Mod + O | Toggle overview |
| Mod + Q | Close window |
| Mod + Shift + E | Quit Niri (confirm) |

## Window Focus

| Shortcut | Action |
| --- | --- |
| Mod + H / Left | Focus column left |
| Mod + L / Right | Focus column right |
| Mod + J / Down | Focus window down |
| Mod + K / Up | Focus window up |
| Mod + Home | Focus first column |
| Mod + End | Focus last column |

## Window Move

| Shortcut | Action |
| --- | --- |
| Mod + Ctrl + H / Left | Move column left |
| Mod + Ctrl + L / Right | Move column right |
| Mod + Ctrl + J / Down | Move window down |
| Mod + Ctrl + K / Up | Move window up |
| Mod + Ctrl + Home | Move column to first |
| Mod + Ctrl + End | Move column to last |

## Workspaces

| Shortcut | Action |
| --- | --- |
| Mod + 1..9 | Focus workspace 1..9 |
| Mod + Ctrl + 1..9 | Move column to workspace 1..9 |
| Mod + Page_Up / I | Focus workspace up |
| Mod + Page_Down / U | Focus workspace down |
| Mod + Shift + Page_Up / I | Move workspace up |
| Mod + Shift + Page_Down / U | Move workspace down |

## Layout and Sizing

| Shortcut | Action |
| --- | --- |
| Mod + R | Switch preset column width |
| Mod + Shift + R | Switch preset window height |
| Mod + Ctrl + R | Reset window height |
| Mod + F | Maximize column |
| Mod + Shift + F | Fullscreen window |
| Mod + M | Maximize window to edges |
| Mod + V | Toggle window floating |
| Mod + W | Toggle tabbed column display |
| Mod + BracketLeft | Consume/expel window left |
| Mod + BracketRight | Consume/expel window right |

## Screenshots

| Shortcut | Action |
| --- | --- |
| Print | Screenshot (interactive) |
| Ctrl + Print | Screenshot screen |
| Alt + Print | Screenshot window |

## Media Keys (default examples)

| Key | Action |
| --- | --- |
| XF86AudioRaiseVolume | Raise volume |
| XF86AudioLowerVolume | Lower volume |
| XF86AudioMute | Toggle mute |
| XF86AudioMicMute | Toggle mic mute |
| XF86AudioPlay | Play/Pause |
| XF86AudioStop | Stop |
| XF86AudioPrev | Previous track |
| XF86AudioNext | Next track |
| XF86MonBrightnessUp | Brightness up |
| XF86MonBrightnessDown | Brightness down |

## System

| Shortcut | Action |
| --- | --- |
| Mod + Escape | Toggle shortcut inhibit |
| Ctrl + Alt + Delete | Quit Niri (confirm) |
| Mod + Shift + P | Power off monitors |

## Notes

- `Mod` is `Super` on TTY and `Alt` when nested under another compositor.
- Niri does not auto-fill `binds {}`. You need to copy default binds into
  your `~/.config/niri/config.kdl` to keep them.
