local filesystem = require("gears.filesystem")

local root_dir = filesystem.get_configuration_dir()
local config = {}

config.root_dir = root_dir
config.terminal = "terminator"
config.modkey = "Mod4"

-- theme
config.wallpaper = root_dir .. "assets/background.jpg"

return config
