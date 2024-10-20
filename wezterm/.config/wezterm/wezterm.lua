-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- theme
config.color_scheme = 'Tokyo Night'

-- font
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 8
config.line_height = 1.25
config.cell_width = 1.1

-- GUI interface
config.enable_tab_bar = false

return config
