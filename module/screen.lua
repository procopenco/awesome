local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local wallpaper_utils = require("utils.wallpaper")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local taskbar_click = function(c)
  if c == _G.client.focus then
    c.minimized = true
  else
    c:emit_signal("request::activate", "tasklist", {raise = true})
  end
end

local taskbar_right_click = function(c)
  awful.menu.client_list({theme = {width = 250}})
end

local tasklist_buttons = gears.table.join(awful.button({}, 1, taskbar_click), awful.button({}, 3, taskbar_right_click))

local screen_setup = function(screen)
  wallpaper_utils.set(screen)
  awful.tag({"master"}, screen)

  local text_widget = {text = "Hello world!", widget = wibox.widget.textbox}

  local tasklistLeft = awful.widget.tasklist {
    screen = screen,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    layout = wibox.layout.flex.vertical(),
    -- update_function = function(w, buttons, label, data, objects)
    --   log.info(type(objects))
    --   awful.widget.common.list_update(w, buttons, label, data, objects)
    -- end,
    widget_template = {
      id = "background_role",
      widget = wibox.container.background,
      create_callback = function(self, c, index, objects)
        if c.class == "Slack" then
          imagebox = self:get_children_by_id("icon_role")[1]
          imagebox:set_image("/usr/share/icons/hicolor/scalable/apps/slack.svg")
        end
      end,
      {
        left = 6,
        top = 2,
        right = 6,
        bottom = 2,
        widget = wibox.container.margin,
        {id = "icon_role", widget = wibox.widget.imagebox},
      },
    },
  }

  local tray = wibox.widget.systray()
  tray:set_horizontal(false)
  tray:set_base_size(30)

  local leftpwibox =
    awful.wibar({position = "left", y = 0, screen = screen, bg = "#ffffff00", ontop = true, width = 48})

  leftpwibox:setup{
    layout = wibox.layout.align.vertical,
    tasklistLeft,
    nil,
    {widget = wibox.container.margin, margins = 10, {layout = wibox.layout.fixed.vertical, tray}},
  }

  screen.promptbox = awful.widget.prompt()

  local topwibox = awful.wibar({position = "top", x = 48, screen = screen, bg = "#ffffff00"})

  topwibox:setup{
    layout = wibox.layout.align.horizontal,
    screen.promptbox,
    nil,
    {layout = wibox.layout.fixed.horizontal, wibox.widget.textclock()},
  }
end

awful.screen.connect_for_each_screen(screen_setup)
_G.screen.connect_signal("property::geometry", wallpaper_utils.set)
