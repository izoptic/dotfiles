local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font 'Cousine Nerd Font'
config.font_size = 15
config.line_height = 1.1

function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'Tokyo Night'
    else
        return 'Tokyo Night Storm'
    end
end

config.color_scheme = scheme_for_appearance(get_appearance())

config.default_cursor_style = 'BlinkingUnderline'
config.cursor_blink_rate = 500
config.cursor_thickness = 3.5
config.colors = {
    cursor_bg = '#f7768e',
    cursor_fg = '#1a1b26',
    cursor_border = '#f7768e',
    split = '#565f89',
}

config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.8,
}

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.scrollback_lines = 100000

config.enable_tab_bar = false

config.keys = {
    {
        key = 'RightArrow',
        mods = 'OPT|CMD',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'UpArrow',
        mods = 'OPT|CMD',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'LeftArrow',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'RightArrow',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
        key = 'UpArrow',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'DownArrow',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = "Enter",
        mods = "SHIFT",
        action = wezterm.action.SendString("\n"),
    }
}

return config
