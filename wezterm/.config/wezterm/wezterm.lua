local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Tokyo Night Storm'
config.enable_tab_bar = false
config.enable_wayland = false
config.font_size = 10
config.default_prog = {
  '/usr/bin/fish',
  '-l'
}

return config
