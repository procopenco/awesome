local gears = require("gears")
local awful = require("awful")
local config = require("config")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local shortcut_utils = require("utils.shortcut")
local add_key = shortcut_utils.add_key
local keys = config.shortcuts.keys

--          awful.key(
--            {modkey}, "Tab", function() end, function()
-- keygrabber.run(
--   function(mods, key, action)
--     log.info("hi2" .. key)
--     print("You did:", gears.debug.dump_return(mods), key, action)
--     keygrabber.stop()
--   end)
-- end),

local next_client_handler = function()
  awful.client.focus.byidx(1)
end

local prev_client_handler = function()
  awful.client.focus.byidx(-1)
end

local swap_with_next_client_handler = function()
  awful.client.swap.byidx(1)
end

local swap_with_prev_client_handler = function()
  awful.client.swap.byidx(-1)
end

local lock_screen_handler = function()
  awful.spawn("i3lock-fancy")
end

local emoji_handler = function()
  awful.spawn("ibus emoji")
end

local increase_volume_handler = function()
  awful.util.spawn("amixer set Master 5%+")
end

local decrease_volume_handler = function()
  awful.util.spawn("amixer set Master 5%-")
end

local toggle_volume_handler = function()
  awful.util.spawn("amixer sset Master toggle")
end

local increase_brightness_handler = function()
  awful.util.spawn("xbacklight -inc 15")
end

local decrease_brightness_handler = function()
  awful.util.spawn("xbacklight -dec 15")
end

local restore_last_minimized_client_handler = function()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
    c:emit_signal("request::activate", "key.unminimize", {raise = true})
  end
end

local launch_terminal_handler = function()
  awful.spawn(config.terminal)
end

local globalkeys = gears.table.join(
                     add_key(keys.help, hotkeys_popup.show_help), add_key(keys.next_client, next_client_handler),
                     add_key(keys.next_client_2, next_client_handler), add_key(keys.prev_client, prev_client_handler),
                     add_key(keys.swap_with_next_client, swap_with_next_client_handler),
                     add_key(keys.swap_with_prev_client, swap_with_prev_client_handler),
                     add_key(keys.launch_terminal, launch_terminal_handler), add_key(keys.reload, _G.awesome.restart),
                     add_key(keys.quit, _G.awesome.quit), add_key(keys.lock, lock_screen_handler),
                     add_key(keys.emoji, emoji_handler), add_key(keys.increase_volume, increase_volume_handler),
                     add_key(keys.decrease_volume, decrease_volume_handler),
                     add_key(keys.toggle_volume, toggle_volume_handler),
                     add_key(keys.increase_brightness, increase_brightness_handler),
                     add_key(keys.decrease_brightness, decrease_brightness_handler),
                     add_key(keys.restore_minimized, restore_last_minimized_client_handler),
                     add_key(keys.launch_menu, menubar.show)
                   )
_G.root.keys(globalkeys)
