local filesystem = require("gears.filesystem")
local global_shortcuts = require("config.global-shortcuts")
local client_shortcuts = require("config.client-shortcuts")

local root_dir = filesystem.get_configuration_dir()
local assets_dir = root_dir .. "assets/"
local config = {}

config.root_dir = root_dir
config.terminal = "terminator"
config.modkey = "Mod4"

-- shortcuts
config.shortcuts = {}
config.shortcuts.groups = {general = "awesome", client = "client", launcher = "launcher"}
config.shortcuts.global = global_shortcuts(config)
config.shortcuts.client = client_shortcuts(config)

-- theme
config.wallpaper = assets_dir .. "wallpaper.jpg"

return config
