local gears = require("gears")
local config = require("config")

local wallpaper_utils = {}

wallpaper_utils.set = function(screen)
  gears.wallpaper.maximized(config.wallpaper, screen, true)
end

return wallpaper_utils
