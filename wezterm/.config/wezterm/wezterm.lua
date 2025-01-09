-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- theme
config.color_scheme = 'Tokyo Night'

-- font
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 8.5
config.line_height = 1.25
config.cell_width = 1.1

-- GUI interface
config.enable_tab_bar = false
config.front_end = "WebGpu"
-- config.max_fps = 60
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.window_padding = {
    bottom = 0,
}

config.keys = {
  -- CTRL-SHIFT-k activates the debug overlay
  { key = 'K', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
}

return config
