local naughty = require('naughty')
local beautiful = require('beautiful')

local dpi = beautiful.xresources.apply_dpi

naughty.config.padding = 20
-- naughty.config.spacing = 80

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.font = 'Roboto Regular 10'
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.border_width = 1
naughty.config.defaults.hover_timeout = nil

function log(message) naughty.notify({text = message}) end
