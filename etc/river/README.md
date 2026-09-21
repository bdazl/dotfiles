# River test session

River 0.4 uses Weir for window management. Hyprland remains the default on
tty1. After `greetd-multi` is enabled, tty2 logs in directly to River and tty3
remains available as a shell. To install the session and launcher:

```sh
cd ~/.etc
bin/install/arch-river
./install
# Switch to tty3 before applying the system greeter changes.
~/.etc/bin/sys/systemd login apply greetd-multi --allow-active-tty
```

The package installer uses `yay -Syu` so Arch's package databases and installed
packages are updated together. It installs the River session dependencies and
Ashrwm, pins Weir to the revision used to develop this configuration, and
installs Weir's two binaries in `~/.local/bin`.
`./install` creates the Dotbot links for `~/.config/river`,
`~/.config/kanshi`, `start-river`, and `start-ashrwm`. Check `riverhalp` for
the shortcuts. `Super+F12` ends the session and returns to the tty2 greeter.
For a quick nested test inside an existing Wayland session, run
`start-river` from a terminal there instead.

Ashrwm is an alternative window manager using the same River compositor and
the same background services. Start it from a shell with `start-ashrwm` after
installing the AUR package. Its layouts are selected with `Super+Space` (tile),
`Super+G` (grid), `Super+S` (scroller), `Super+C` (monocle), and
`Super+F` (floating). `Super+V` toggles the focused window between tiled and
floating.

The DP-1 output profile uses the display's EDID mode at 164.958 Hz. If the
display rejects that mode, inspect its modes in the river session and adjust
`~/.config/kanshi/config`. The wallpaper, launcher, notifications,
clipboard history, input method, audio, and most Waybar modules are shared with
Hyprland. The river bar and active-window screenshot get state through Weir IPC.
Weir currently exposes focus cycling rather than a focus-by-window-ID command,
so the Hyprland `Super+w` Rofi window picker is not mapped in this test session.

River's output, rendering, and screen sharing on the installed NVIDIA driver
need a live session to verify. A failed test does not change the tty1 Hyprland
login. Use tty3 for a shell if tty2 is occupied.
