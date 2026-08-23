-- NOTE: when keybinds, autostart applications or related tooling
-- change here, also update hyprhalp() in etc/zsh/conf.d/alias.zsh to keep the
-- cheat sheet in sync.

local main_modifier = "SUPER"
local menu = "rofi -theme ~/.config/rofi/catppuccin.rasi"

local commands = {
    browser = "firefox",
    clipboard_history = "~/.etc/bin/hypr/cliphist-rofi",
    gamma_toggle = "pkill gammastep || gammastep -l 59.3:18.1",
    notification_history = "~/.etc/bin/hypr/dunst-history",
    run_menu = menu .. " -combi-modi run,drun -show run",
    screenshot_active = "~/.etc/bin/hypr/grim-active",
    screenshot_region = [[grim -g "$(slurp)"]],
    terminal = "ghostty --fullscreen=false",
    window_menu = menu .. " -show window",
}

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
local function configure_monitors()
    local monitors = {
        {
            output = "",
            mode = "preferred",
            position = "auto",
            scale = "auto",
        },
        {
            output = "DP-1",
            mode = "2560x1440@164",
            position = "0x0",
            scale = 1,
        },
    }

    for _, monitor in ipairs(monitors) do
        hl.monitor(monitor)
    end
end

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
local function configure_autostart()
    local startup_commands = {
        "waybar",
        "hyprpaper",
        "dunst",
        "gammastep -l 59.3:18.1",
        "wl-paste --watch cliphist store",
        "/usr/lib/polkit-kde-authentication-agent-1",
        "fcitx5 -d",
    }

    hl.on("hyprland.start", function()
        for _, command in ipairs(startup_commands) do
            hl.exec_cmd(command)
        end
    end)
end

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
local function configure_environment()
    local variables = {
        { name = "XCURSOR_SIZE", value = "24" },
        { name = "XDG_SESSION_TYPE", value = "wayland" },
        { name = "QT_IM_MODULE", value = "fcitx" },
        { name = "XMODIFIERS", value = "@im=fcitx" },
    }

    for _, variable in ipairs(variables) do
        hl.env(variable.name, variable.value)
    end
end

-- See https://wiki.hypr.land/Configuring/Basics/Variables/
local function configure_options()
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
end

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
local function configure_animations()
    local animations = {
        { leaf = "windows", enabled = true, speed = 1, bezier = "myBezier" },
        { leaf = "windowsOut", enabled = true, speed = 2, bezier = "default", style = "popin 80%" },
        { leaf = "border", enabled = true, speed = 4, bezier = "default" },
        { leaf = "borderangle", enabled = true, speed = 4, bezier = "default" },
        { leaf = "fade", enabled = true, speed = 2, bezier = "default" },
        { leaf = "workspaces", enabled = true, speed = 3, bezier = "default" },
    }

    hl.curve("myBezier", {
        type = "bezier",
        points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
    })

    for _, animation in ipairs(animations) do
        hl.animation(animation)
    end
end

local function with_modifier(key)
    return main_modifier .. " + " .. key
end

local function add_workspace_bindings(bindings)
    for workspace = 1, 10 do
        local key = workspace % 10

        bindings[#bindings + 1] = {
            keys = with_modifier(key),
            dispatcher = hl.dsp.focus({ workspace = workspace }),
        }
        bindings[#bindings + 1] = {
            keys = with_modifier("SHIFT + " .. key),
            dispatcher = hl.dsp.window.move({ workspace = workspace }),
        }
    end
end

local function build_bindings()
    local bindings = {
        -- Window management.
        { keys = with_modifier("F"), dispatcher = hl.dsp.window.fullscreen({ mode = "maximized" }) },
        { keys = with_modifier("SHIFT + F"), dispatcher = hl.dsp.window.fullscreen({ mode = "fullscreen" }) },
        { keys = with_modifier("D"), dispatcher = hl.dsp.window.close() },
        { keys = with_modifier("F12"), dispatcher = hl.dsp.exit() },
        { keys = with_modifier("P"), dispatcher = hl.dsp.window.pseudo() },
        { keys = with_modifier("SPACE"), dispatcher = hl.dsp.layout("togglesplit") },
        { keys = with_modifier("V"), dispatcher = hl.dsp.window.float() },

        -- Applications and utilities.
        { keys = with_modifier("RETURN"), dispatcher = hl.dsp.exec_cmd(commands.terminal) },
        { keys = with_modifier("O"), dispatcher = hl.dsp.exec_cmd(commands.terminal) },
        { keys = with_modifier("E"), dispatcher = hl.dsp.exec_cmd(commands.browser) },
        { keys = with_modifier("R"), dispatcher = hl.dsp.exec_cmd(commands.run_menu) },
        { keys = with_modifier("W"), dispatcher = hl.dsp.exec_cmd(commands.window_menu) },
        { keys = "PRINT", dispatcher = hl.dsp.exec_cmd(commands.screenshot_region) },
        { keys = with_modifier("PRINT"), dispatcher = hl.dsp.exec_cmd(commands.screenshot_active) },
        { keys = with_modifier("N"), dispatcher = hl.dsp.exec_cmd(commands.notification_history) },
        { keys = with_modifier("G"), dispatcher = hl.dsp.exec_cmd(commands.gamma_toggle) },
        { keys = with_modifier("C"), dispatcher = hl.dsp.exec_cmd(commands.clipboard_history) },

        -- Focus and workspace navigation.
        { keys = with_modifier("H"), dispatcher = hl.dsp.focus({ direction = "left" }) },
        { keys = with_modifier("L"), dispatcher = hl.dsp.focus({ direction = "right" }) },
        { keys = with_modifier("K"), dispatcher = hl.dsp.focus({ direction = "up" }) },
        { keys = with_modifier("J"), dispatcher = hl.dsp.focus({ direction = "down" }) },
        { keys = with_modifier("SHIFT + L"), dispatcher = hl.dsp.focus({ workspace = "+1" }) },
        { keys = with_modifier("SHIFT + H"), dispatcher = hl.dsp.focus({ workspace = "e-1" }) },

        -- Scratchpad.
        { keys = with_modifier("SHIFT + S"), dispatcher = hl.dsp.window.move({ workspace = "special" }) },
        { keys = with_modifier("SHIFT + V"), dispatcher = hl.dsp.workspace.toggle_special() },

        -- Mouse actions.
        { keys = with_modifier("mouse:272"), dispatcher = hl.dsp.window.drag(), options = { mouse = true } },
        { keys = with_modifier("mouse:273"), dispatcher = hl.dsp.window.resize(), options = { mouse = true } },
    }

    add_workspace_bindings(bindings)

    return bindings
end

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local function configure_bindings()
    for _, binding in ipairs(build_bindings()) do
        if binding.options then
            hl.bind(binding.keys, binding.dispatcher, binding.options)
        else
            hl.bind(binding.keys, binding.dispatcher)
        end
    end
end

local function configure()
    configure_monitors()
    configure_autostart()
    configure_environment()
    configure_options()
    configure_animations()
    configure_bindings()
end

configure()
