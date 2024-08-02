local wezterm = require 'wezterm';
local mux = wezterm.mux;
local action = wezterm.action;

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Atelierheath (dark) (terminal.sexy)'

local quakize_window = function(window)
    local overrides = window:get_config_overrides() or {}
    overrides.window_decorations = "NONE"
    window:set_config_overrides(overrides)

    local current_screen = wezterm.gui.screens()["active"]
    window:set_position(current_screen["x"], current_screen["y"])
    window:set_inner_size(current_screen["width"], 0.4 * current_screen["height"])
end

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    quakize_window(window:gui_window())
    pane:split{ size = 0.5 }
end)

config.font = wezterm.font("MesloLGS NF");
config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7,
};
config.scrollback_lines = 5000;
config.adjust_window_size_when_changing_font_size = false;
config.hide_tab_bar_if_only_one_tab = true;
config.native_macos_fullscreen_mode = true;

config.keys = {
    {
        key = 'd',
        mods = 'SUPER',
        action = action.SplitHorizontal{ domain = 'CurrentPaneDomain' },
    },
    {
        key = 'D',
        mods = 'SUPER|SHIFT',
        action = action.SplitVertical{ domain = 'CurrentPaneDomain' },
    },
    {
        key = '[',
        mods = 'SUPER',
        action = action.ActivatePaneDirection 'Left',
    },
    {
        key = ']',
        mods = 'SUPER',
        action = action.ActivatePaneDirection 'Right',
    },
    {
        key = 'u',
        mods = 'SUPER',
        action = action.EmitEvent 'quakeify',
    },
}

wezterm.on('quakeify', function (window, pane)
    quakize_window(window)
end)

return config
