local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.front_end = "WebGpu"

config.color_scheme = 'Kanagawa (Gogh)'
config.window_background_opacity = 0.90

config.tab_bar_at_bottom = true

config.font = wezterm.font {
  family = 'JetBrains Mono',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}
config.font_size = 14

local host_profile = {
  label = 'Host',
  args = { 'fish', '-l' },
  cwd = '$HOME',
}

local act = wezterm.action

config.keys = {
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = act.SpawnCommandInNewTab(host_profile)
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'powershell.exe',  '-nologo' }
end

return config
