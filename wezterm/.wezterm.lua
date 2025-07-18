-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'rose-pine'
config.color_scheme = 'tokyonight_storm'

config.scrollback_lines = 10000

config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },

}

config.line_height = 1.4

config.keys = {
  -- paste from the clipboard
  { key = 'V', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
  -- Clears the scrollback and viewport leaving the prompt line the new first line.
  {
    key = 'K',
    mods = 'CMD',
    action = act.ClearScrollback 'ScrollbackAndViewport',
  },
}

config.font = wezterm.font 'IBM Plex Mono'
-- config.font = wezterm.font 'Fira Code'
config.font_size = 16.0
config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
}
config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 10
-- config.window_background_image_hsb = {
--   brightness = 0.8,  -- Very dark (experiment: 0.1-0.4)
--   hue = 1.0,         -- Keep original hue
--   saturation = 1.0,  -- Desaturate significantly
-- }
-- config.window_background_image = '/Users/nate/Desktop/peng.png'
-- config.window_background_image = '/Users/nate/Desktop/vapor1.jpg'
-- and finally, return the configuration to wezterm
return config
