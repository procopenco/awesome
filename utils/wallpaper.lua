local gears = require("gears")
local config = require("config")

local function set_wallpaper(screen) gears.wallpaper.maximized(config.wallpaper, screen, true) end

return set_wallpaper
