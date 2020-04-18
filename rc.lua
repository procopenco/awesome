require("module.notify")
require("module.error-handler")
require("module.global-keys")
require("awful.autofocus")
local config = require("config")
local wallpaper_utils = require("utils.wallpaper")

local beautiful = require("beautiful")
beautiful.init("~/.config/awesome/themes/my/theme.lua")
-- ==========================================

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local menubar = require("menubar")

local tasklist_buttons = gears.table.join(
                           awful.button(
                             {}, 1, function(c)
      if c == client.focus then
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

screen.connect_signal("property::geometry", wallpaper_utils.set)

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

clientkeys = gears.table.join(
               awful.key(
                 {config.modkey}, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, {description = "toggle fullscreen", group = "client"}
               ), awful.key(
                 {config.modkey, "Shift"}, "c", function(c)
      c:kill()
    end, {description = "close", group = "client"}
               ), awful.key(
                 {config.modkey, "Control"}, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, {description = "move to master", group = "client"}
               ), awful.key(
                 {config.modkey}, "o", function(c)
      c:move_to_screen()
    end, {description = "move to screen", group = "client"}
               ), awful.key(
                 {config.modkey}, "t", function(c)
      c.ontop = not c.ontop
    end, {description = "toggle keep on top", group = "client"}
               ), awful.key(
                 {config.modkey}, "n", function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end, {description = "minimize", group = "client"}
               ), awful.key(
                 {config.modkey}, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, {description = "(un)maximize", group = "client"}
               )
             )

clientbuttons = gears.table.join(
                  awful.button(
                    {config.modkey}, 1, function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
    end
                  ), awful.button(
                    {config.modkey}, 3, function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
    end
                  )
                )

awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  }, -- Floating clients.
  {rule_any = {type = {"normal", "dialog"}}, properties = {titlebars_enabled = true}},
}

client.connect_signal(
  "manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
  "request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
                      awful.button(
                        {}, 1, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(c)
        end
                      ), awful.button(
                        {}, 3, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(c)
        end
                      )
                    )

    awful.titlebar(c):setup{
      { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout = wibox.layout.fixed.horizontal,
      },
      { -- Middle
        { -- Title
          align = "center",
          widget = awful.titlebar.widget.titlewidget(c),
        },
        buttons = buttons,
        layout = wibox.layout.flex.horizontal,
      },
      { -- Right
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal(),
      },
      layout = wibox.layout.align.horizontal,
    }
  end
)
