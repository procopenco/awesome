local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local wallpaper_utils = require("utils.wallpaper")

local tasklist_buttons = gears.table.join(
                           awful.button(
                             {}, 1, function(c)
      if c == _G.client.focus then
        c.minimized = true
      else
        c:emit_signal("request::activate", "tasklist", {raise = true})
      end
    end
                           ), awful.button(
                             {}, 3, function()
      awful.menu.client_list({theme = {width = 250}})
    end
                           )
                         )

_G.screen.connect_signal("property::geometry", wallpaper_utils.set)

awful.screen.connect_for_each_screen(
  function(s)
    -- Wallpaper
    wallpaper_utils.set(s)

    -- Each screen has its own tag table.
    awful.tag({"1"})

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist_buttons,
    }

    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", screen = s})

    -- Add widgets to the wibox
    s.mywibox:setup{
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        -- mylauncher,
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        awful.widget.keyboardlayout(),
        wibox.widget.systray(),
        wibox.widget.textclock(),
      },
    }
  end
)
