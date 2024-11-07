local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 14.0
config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
config.color_scheme = 'Catppuccin Mocha'

return config
