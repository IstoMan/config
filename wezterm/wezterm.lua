-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'tokyonight_storm'
config.cursor_blink_rate = 0
config.enable_wayland = false
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'
config.font = wezterm.font { family = 'JetBrains Mono'}
config.window_background_opacity = 0.9
config.font_size = 12.0
config.font_rules = {
  -- Bold-and-italic
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font {
      family = 'Victor Mono',
      italic = true,
    },
  },

  -- normal-intensity-and-italic
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font {
      family = 'Victor Mono',
      weight = 'DemiLight',
      italic = true,
    },
  },

  -- half-intensity-and-italic (half-bright or dim); use a lighter weight font
  {
    intensity = 'Half',
    italic = true,
    font = wezterm.font {
      family = 'Victor Mono',
      weight = 'Light',
      italic = true,
    },
  },
}
-- and finally, return the configuration to wezterm
return config
