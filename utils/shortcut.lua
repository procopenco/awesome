local awful = require("awful")

local shortcut_utils = {}

shortcut_utils.add_key = function(config_item, press_handler, release_handler)
  return awful.key(
           config_item.mod, config_item.key, press_handler, release_handler,
           {description = config_item.description, group = config_item.group}
         )
end

return shortcut_utils
