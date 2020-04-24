local naughty = require("naughty")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi

naughty.config.padding = 10
-- naughty.config.spacing = 80

naughty.config.defaults.timeout = 0
naughty.config.defaults.screen = 1
naughty.config.defaults.position = "bottom_left"
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.font = "Roboto Regular 10"
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.border_width = 1
naughty.config.defaults.hover_timeout = nil

log = {}

function log.info(message, title)
  title = title or "Info"

  naughty.notify({title = title, text = message, timeout = 5})
end

function log.error(message, title)
  title = title or "Critical error"
  naughty.notify({preset = naughty.config.presets.critical, title = title, text = message})
end
