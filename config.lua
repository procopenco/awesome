local filesystem = require("gears.filesystem")

local root_dir = filesystem.get_configuration_dir()
local assets_dir = root_dir .. "assets/"
local config = {}

config.root_dir = root_dir
config.terminal = "terminator"
config.modkey = "Mod4"

-- shortcuts
config.shortcuts = {}
config.shortcuts.keys = {}
config.shortcuts.groups = {general = "awesome", client = "client", launcher = "launcher"}

config.shortcuts.keys.help = {
  mod = {config.modkey},
  key = "s",
  description = "show help popup",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.reload = {
  mod = {config.modkey, "Control"},
  key = "r",
  description = "reload awesome",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.quit = {
  mod = {config.modkey, "Shift"},
  key = "q",
  description = "quit awesome",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.lock = {
  mod = {config.modkey},
  key = "l",
  description = "lock screen",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.emoji = {
  mod = {"Control"},
  key = "space",
  description = "Emoji",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.increase_volume = {
  mod = {},
  key = "XF86AudioRaiseVolume",
  description = "increase volume",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.decrease_volume = {
  mod = {},
  key = "XF86AudioLowerVolume",
  description = "decrease volume",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.toggle_volume = {
  mod = {},
  key = "XF86AudioMute",
  description = "on/off volume",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.increase_brightness = {
  mod = {},
  key = "XF86MonBrightnessUp",
  description = "increase brightness",
  group = config.shortcuts.groups.general,
}
config.shortcuts.keys.decrease_brightness = {
  mod = {},
  key = "XF86MonBrightnessDown",
  description = "decrease brightness",
  group = config.shortcuts.groups.general,
}

config.shortcuts.keys.smart_client_navigation = {
  mod = {config.modkey},
  key = "Tab",
  description = "smart client navigation",
  group = config.shortcuts.groups.client,
}
config.shortcuts.keys.swap_with_next_client = {
  mod = {config.modkey, "Shift"},
  key = "Right",
  description = "swap with next client",
  group = config.shortcuts.groups.client,
}
config.shortcuts.keys.swap_with_prev_client = {
  mod = {config.modkey, "Shift"},
  key = "Left",
  description = "swap with previous client",
  group = config.shortcuts.groups.client,
}
config.shortcuts.keys.restore_minimized = {
  mod = {config.modkey, "Shift"},
  key = "m",
  description = "restore minimized",
  group = config.shortcuts.groups.client,
}
config.shortcuts.keys.launch_terminal = {
  mod = {config.modkey},
  key = "Return",
  description = "open a terminal",
  group = config.shortcuts.groups.launcher,
}
config.shortcuts.keys.launch_menu = {
  mod = {config.modkey},
  key = "p",
  description = "show the menubars",
  group = config.shortcuts.groups.launcher,
}

-- theme
config.wallpaper = assets_dir .. "wallpaper.jpg"

return config
