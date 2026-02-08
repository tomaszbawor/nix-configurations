# LLM assessment: NixOS desktop (speed + streaming)

Date: 2026-02-08

Scope: This review covers the NixOS desktop config in this repo, with emphasis on (1) day-to-day responsiveness and build speed, and (2) a reliable Wayland + OBS streaming setup.

## Context (from repo)

- System: `nixosConfigurations.desktop` (`flake.nix`)
- Desktop session: Hyprland (Wayland) via greetd/tuigreet (`modules/nixos/xserver.nix`, `modules/nixos/hyprland.nix`)
- GPU: NVIDIA (`modules/nixos/nvidia-drivers.nix`)
- Kernel: `linuxPackages_zen` (`modules/nixos/boot.nix`)
- Audio: PipeWire enabled with ALSA + Pulse (`modules/nixos/services.nix`)
- OBS: enabled with a solid plugin set (`modules/nixos/obs.nix`)

## What is configured today (evidence)

### OBS

File: `modules/nixos/obs.nix`

- `programs.obs-studio.enable = true;`
- `pkgs.obs-studio.override { cudaSupport = true; }`
- Plugins include: `wlrobs`, `obs-pipewire-audio-capture`, `obs-vkcapture`, `obs-gstreamer`, `obs-shaderfilter`, `advanced-scene-switcher`, etc.

### Wayland capture portals

File: `modules/nixos/hyprland.nix`

- `xdg.portal.enable = true;`
- Uses Hyprland portal + GTK portal: `xdg-desktop-portal-hyprland`, `xdg-desktop-portal-gtk`
- `xdg.portal.wlr.enable = false;` (explicitly prefers Hyprland portal)

### Audio stack

File: `modules/nixos/services.nix`

- `services.pipewire.enable = true;`
- `services.pipewire.alsa.enable = true;`
- `services.pipewire.alsa.support32Bit = true;`
- `services.pipewire.pulse.enable = true;`
- Not explicitly set: `security.rtkit.enable`, `services.pipewire.wireplumber.enable`

### Nix performance knobs

File: `modules/nixos/system.nix`

- `nix.settings.cores = 8;`
- `nix.settings.max-jobs = 2;` (this is a likely build-speed bottleneck)
- `nix.settings.auto-optimise-store = true;`
- Substituters: `cache.nixos.org`, `nix-community.cachix.org`, `hyprland.cachix.org`
- Auto upgrades: `system.autoUpgrade.channel = "https://nixos.org/channels/nixos-24.11";` while `flake.nix` tracks `nixos-unstable`

### Potential boot/login stall

File: `modules/nixos/synology-drive.nix`

- NFS mount is configured without automount/noauto. If the NAS is offline/slow, this can cause long hangs.

### Swap

File: `hosts/desktop/hardware-configuration.nix`

- A swap partition is present.
- No zram config is present in this repo.

## High-impact recommendations (do first)

### 1) Enable realtime scheduling for low-latency audio

- Add: `security.rtkit.enable = true;`
- Why: PipeWire behaves much better under load (builds + OBS + browser), reducing xruns/crackles and improving sync stability.
- Where: a good place is `modules/nixos/services.nix` (or a dedicated audio module).

### 2) Fix Nix parallelism for faster rebuilds/dev loops

- Change: `nix.settings.max-jobs = 2;` -> `nix.settings.max-jobs = "auto";` (or a higher value appropriate for your CPU).
- Consider removing or relaxing `nix.settings.cores = 8;` unless you are intentionally capping.
- Why: the current config artificially limits build throughput.
- Where: `modules/nixos/system.nix`

### 3) Add zram to keep the desktop responsive under memory pressure

- Add: `zramSwap.enable = true;` (tune size if needed)
- Why: prevents UI stalls when compiling, running containers, and streaming simultaneously.

### 4) Make the NAS mount on-demand

- Convert the NFS mount to a systemd automount (`x-systemd.automount`), with `_netdev` and timeouts.
- Why: unreachable storage should not block boot/login or freeze apps waiting on IO.

## Streaming-specific improvements

### Virtual camera (OBS -> Zoom/Meet/Discord)

- Add v4l2loopback support (kernel module + package for your kernel).
- Ensure user is in the `video` group (and sometimes `input`, depending on devices).

### Encoder sanity checks (NVIDIA)

- In OBS: Settings -> Output -> Encoder should show NVENC options.
- CLI check:

```bash
ffmpeg -hide_banner -encoders | grep -E 'nvenc|vaapi'
```

### Portal troubleshooting checklist (Hyprland)

- Services should be running:

```bash
systemctl --user status xdg-desktop-portal xdg-desktop-portal-hyprland
```

- Logs:

```bash
journalctl --user -u xdg-desktop-portal -u xdg-desktop-portal-hyprland -b
```

### Environment variables

- In `modules/nixos/hyprland.nix` you set `DISPLAY = ":0";` even though the session is Wayland.
- Recommendation: avoid forcing `DISPLAY` unless you have a specific app that requires it; it can cause subtle capture/app behavior issues on Wayland.

## Longer-term polish

### Align auto-upgrades with a flake workflow

- Option A (flake-native): use `system.autoUpgrade.flake = "/home/tomasz/nix-configurations#desktop";`
- Option B (explicit control): disable `system.autoUpgrade` and use `nh` (`modules/nixos/nh.nix`) for upgrades
- Why: `flake.nix` tracks `nixos-unstable` but the auto-upgrade channel is pinned to `nixos-24.11`, which is an easy source of confusion and churn.

### Add scheduled GC/optimise

- You have `auto-optimise-store = true` but no scheduled `nix.gc.*` / `nix.optimise.*`.
- Adding a simple weekly GC helps prevent slowdowns caused by disk pressure.

### NVIDIA driver pinning risk

- `modules/nixos/nvidia-drivers.nix` pins a custom driver via `mkDriver`.
- This can be brittle across kernel updates and can impact NVENC/OBS stability.
- If stability matters more than chasing a specific version, consider using `config.boot.kernelPackages.nvidiaPackages.production` unless you need that exact pin.

## Verification commands

- Evaluate/build:

```bash
nix flake check --all-systems
nixos-rebuild build --flake .#desktop
```

- Runtime health:

```bash
systemctl --user status pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland
```
