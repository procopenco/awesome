local filesystem = require("gears.filesystem")
local root = filesystem.get_configuration_dir()

local config = {}

config.terminal = "terminator"
config.modkey = "Mod4"

config.wallpaper = root .. "assets/background.jpg"

return config
