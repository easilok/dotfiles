-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- theme
local light_color_scheme = "Tokyo Night Day"
local dark_color_scheme = "Tokyo Night"
config.color_scheme = dark_color_scheme

-- light/dark theme toggler event 
wezterm.on("toggle-dark-mode", function(window,pane)
  local overrides = window:get_config_overrides() or {}
  if (overrides.color_scheme == light_color_scheme)
  then
    overrides.color_scheme = dark_color_scheme
  else
    overrides.color_scheme = light_color_scheme
  end
  window:set_config_overrides(overrides)
end)

-- font
-- config.font = wezterm.font 'Hack Nerd Font'
-- config.font_size = 8.5
config.font = wezterm.font {
    family = 'Iosevka Term',
    stretch = 'Expanded',
    weight = 'Regular',
    -- Font options
}
config.font_size = 8.5
config.line_height = 1.2
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
    -- CTRL-SHIFT-j toggles dark/light theme
    { key = 'J', mods = 'CTRL', action = wezterm.action{EmitEvent="toggle-dark-mode"} },
}

return config
