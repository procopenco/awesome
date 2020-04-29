local gears = require("gears")
local awful = require("awful")
local config = require("config")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local shortcut_utils = require("utils.shortcut")
local add_key = shortcut_utils.add_key
local global = config.shortcuts.global

local function swap_with_next_client_handler()
  awful.client.swap.byidx(1)
end

local function swap_with_prev_client_handler()
  awful.client.swap.byidx(-1)
end

local function lock_screen_handler()
  awful.spawn("i3lock-fancy")
end

local function emoji_handler()
  awful.spawn("ibus emoji")
end

local function increase_volume_handler()
  awful.util.spawn("amixer set Master 5%+")
end

local function decrease_volume_handler()
  awful.util.spawn("amixer set Master 5%-")
end

local function toggle_volume_handler()
  awful.util.spawn("amixer sset Master toggle")
end

local function increase_brightness_handler()
  awful.util.spawn("xbacklight -inc 15")
end

local function decrease_brightness_handler()
  awful.util.spawn("xbacklight -dec 15")
end

local function restore_last_minimized_client_handler()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
    c:emit_signal("request::activate", "key.unminimize", {raise = true})
  end
end

local launch_terminal_handler = function()
  awful.spawn(config.terminal)
end

local smart_client_navigation_handler = function()
  _G.client.focus.smart_history.freeze()
  _G.client.focus.smart_history.focus_prev()

  _G.keygrabber.run(
    function(mods, key, action)
      if action == "press" and key == "Tab" then
        _G.client.focus.smart_history.focus_prev()
      end

      if action == "release" and key == "Super_L" then
        _G.client.focus.smart_history.unfreeze()
        _G.keygrabber.stop()
      end
    end
  )
end

_G.root.keys(
  gears.table.join(
    add_key(global.help, hotkeys_popup.show_help),
    add_key(global.smart_client_navigation, smart_client_navigation_handler),
    add_key(global.swap_with_next_client, swap_with_next_client_handler),
    add_key(global.swap_with_prev_client, swap_with_prev_client_handler),
    add_key(global.launch_terminal, launch_terminal_handler), add_key(global.reload, _G.awesome.restart),
    add_key(global.quit, _G.awesome.quit), add_key(global.lock, lock_screen_handler),
    add_key(global.emoji, emoji_handler), add_key(global.increase_volume, increase_volume_handler),
    add_key(global.decrease_volume, decrease_volume_handler), add_key(global.toggle_volume, toggle_volume_handler),
    add_key(global.increase_brightness, increase_brightness_handler),
    add_key(global.decrease_brightness, decrease_brightness_handler),
    add_key(global.restore_minimized, restore_last_minimized_client_handler), add_key(global.launch_menu, menubar.show)
  )
)
