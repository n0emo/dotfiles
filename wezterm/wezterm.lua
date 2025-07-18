local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Kanagawa (Gogh)'
config.window_background_opacity = 0.9
config.win32_system_backdrop = "Disable"

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
  config.default_prog = { 'nu' }
end

wezterm.on("open-uri", function(window, pane, uri)
  if os.getenv("KDE_FULL_SESSION") ~= "true" then
    return true
  end

  local nuri, n = string.gsub(uri, "file://" .. wezterm.hostname(), "file://")
  if n == 1 then
    window:perform_action(
      wezterm.action.SpawnCommandInNewWindow({
        args = { "kioclient", "exec", nuri },
      }),
      pane
    )
    return false
  end
end)

return config
