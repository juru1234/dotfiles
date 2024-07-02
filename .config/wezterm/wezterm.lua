-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_decorations = "None"
config.enable_tab_bar = false
-- For example, changing the color scheme:
config.color_scheme = 'Gruvbox dark, medium (base16)'
config.font_size = 12

return config
