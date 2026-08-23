-- NOTE (claude): when keybinds, autostart applications or related tooling
-- change here, also update hyprhalp() in etc/zsh/conf.d/alias.zsh to keep the
-- cheat sheet in sync.

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.monitor({
    output = "DP-1",
    mode = "2560x1440@164",
    position = "0x0",
    scale = 1,
})

local terminal = "ghostty --fullscreen=false"
local menu = "rofi -theme ~/.config/rofi/catppuccin.rasi"
local browser = "firefox"
local printActive = "~/.etc/bin/hypr/grim-active"

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dunst")
    hl.exec_cmd("gammastep -l 59.3:18.1")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("fcitx5 -d")
end)

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")

-- See https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    input = {
        kb_layout = "se",
        kb_model = "pc105",
        kb_options = "caps:escape",
        repeat_rate = 45,
        repeat_delay = 250,
        numlock_by_default = true,
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },

    general = {
        gaps_in = 1,
        gaps_out = 3,
        border_size = 3,
        col = {
            active_border = {
                colors = { "rgba(07f0eaee)", "rgba(f59538ff)" },
                angle = 20,
            },
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },

    decoration = {
        rounding = 3,
        blur = {
            enabled = true,
            size = 4,
            passes = 1,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        force_split = 2,
    },

    master = {
        orientation = "left",
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("myBezier", {
    type = "bezier",
    points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})

hl.animation({ leaf = "windows", enabled = true, speed = 1, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default" })

local mod = "SUPER"

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + D", hl.dsp.window.close())
hl.bind(mod .. " + F12", hl.dsp.exit())

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + O", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu .. " -combi-modi run,drun -show run"))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(menu .. " -show window"))

hl.bind("PRINT", hl.dsp.exec_cmd([[grim -g "$(slurp)"]]))
hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd(printActive))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("~/.etc/bin/hypr/dunst-history"))
hl.bind(mod .. " + G", hl.dsp.exec_cmd("pkill gammastep || gammastep -l 59.3:18.1"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("~/.etc/bin/hypr/cliphist-rofi"))

hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + SPACE", hl.dsp.layout("togglesplit"))

-- Move focus with mod + vim keys.
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mod + [0-9], and move windows with mod + shift + [0-9].
for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

-- Cycle through workspaces with mod + shift + vim keys.
hl.bind(mod .. " + SHIFT + L", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + SHIFT + H", hl.dsp.focus({ workspace = "e-1" }))

-- Use the default special workspace as a scratchpad.
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mod .. " + SHIFT + V", hl.dsp.workspace.toggle_special())
hl.bind(mod .. " + V", hl.dsp.window.float())

-- Move and resize windows with mod + LMB/RMB and dragging.
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
