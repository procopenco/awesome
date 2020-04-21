local filesystem = require("gears.filesystem")

local root_dir = filesystem.get_configuration_dir()
local assets_dir = root_dir .. "assets/"
local config = {}

config.root_dir = root_dir
config.terminal = "terminator"
config.modkey = "Mod4"

-- theme
config.wallpaper = assets_dir .. "wallpaper.jpg"

return config
