require("module.notify")
require("module.error-handler")
require("awful.autofocus")

local beautiful = require("beautiful")
beautiful.init("~/.config/awesome/themes/my/theme.lua")
-- ==========================================

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

local tasklist_buttons = gears.table.join(
                           awful.button(
                             {}, 1, function(c)
      if c == client.focus then
        c.minimized = true
      else
        c:emit_signal("request::activate", "tasklist", {raise = true})
      end
    end), awful.button({}, 3, function() awful.menu.client_list({theme = {width = 250}}) end))

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(
  function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"1"})

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", screen = s})

    -- Add widgets to the wibox
    s.mywibox:setup{
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        -- mylauncher,
        s.mypromptbox
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        awful.widget.keyboardlayout(),
        wibox.widget.systray(),
        wibox.widget.textclock()
      }
    }
  end)

-- {{{ Key bindings
globalkeys = gears.table.join(
               awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
                 awful.key(
                   {modkey}, "Tab", function() awful.client.focus.byidx(1) end,
                     {description = "focus next by index", group = "client"}), awful.key(
                   {modkey}, "Right", function() awful.client.focus.byidx(1) end,
                     {description = "focus next by index", group = "client"}), awful.key(
                   {modkey}, "Left", function() awful.client.focus.byidx(-1) end,
                     {description = "focus previous by index", group = "client"}), awful.key(
                   {modkey, "Shift"}, "Right", function() awful.client.swap.byidx(1) end,
                     {description = "swap with next client by index", group = "client"}), awful.key(
                   {modkey, "Shift"}, "Left", function() awful.client.swap.byidx(-1) end,
                     {description = "swap with previous client by index", group = "client"}), awful.key(
                   {modkey, "Control"}, "j", function() awful.screen.focus_relative(1) end,
                     {description = "focus the next screen", group = "screen"}), awful.key(
                   {modkey, "Control"}, "k", function() awful.screen.focus_relative(-1) end,
                     {description = "focus the previous screen", group = "screen"}), awful.key(
                   {modkey}, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),
                 awful.key(
                   {modkey}, "Return", function() awful.spawn(terminal) end,
                     {description = "open a terminal", group = "launcher"}), awful.key(
                   {modkey, "Control"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
                 awful.key({modkey, "Shift"}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
                 awful.key(
                   {modkey}, "l", function() awful.spawn("i3lock-fancy") end,
                     {description = "lock screen", group = "awesome"}), awful.key(
                   {"Control"}, "space", function() awful.spawn("ibus emoji") end,
                     {description = "Emoji", group = "awesome"}), awful.key(
                   {modkey, "Control"}, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then c:emit_signal("request::activate", "key.unminimize", {raise = true}) end
      end, {description = "restore minimized", group = "client"}), -- Prompt
    awful.key(
                   {modkey}, "r", function() awful.screen.focused().mypromptbox:run() end,
                     {description = "run prompt", group = "launcher"}), awful.key(
                   {modkey}, "x", function()
        awful.prompt.run {
          prompt = "Run Lua code: ",
          textbox = awful.screen.focused().mypromptbox.widget,
          exe_callback = awful.util.eval,
          history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
      end, {description = "lua execute prompt", group = "awesome"}), -- Menubar
    awful.key({modkey}, "p", function() menubar.show() end, {description = "show the menubar", group = "launcher"}))

clientkeys = gears.table.join(
               awful.key(
                 {modkey}, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, {description = "toggle fullscreen", group = "client"}),
                 awful.key({modkey, "Shift"}, "c", function(c) c:kill() end, {description = "close", group = "client"}),
                 awful.key(
                   {modkey, "Control"}, "Return", function(c) c:swap(awful.client.getmaster()) end,
                     {description = "move to master", group = "client"}), awful.key(
                   {modkey}, "o", function(c) c:move_to_screen() end, {description = "move to screen", group = "client"}),
                 awful.key(
                   {modkey}, "t", function(c) c.ontop = not c.ontop end,
                     {description = "toggle keep on top", group = "client"}), awful.key(
                   {modkey}, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end, {description = "minimize", group = "client"}), awful.key(
                   {modkey}, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
      end, {description = "(un)maximize", group = "client"}))

clientbuttons = gears.table.join(
                  awful.button(
                    {modkey}, 1, function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
    end), awful.button(
                    {modkey}, 3, function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
    end))

root.keys(globalkeys)

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
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }, -- Floating clients.
  {rule_any = {type = {"normal", "dialog"}}, properties = {titlebars_enabled = true}}
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
  end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
  "request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
                      awful.button(
                        {}, 1, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(c)
        end), awful.button(
                        {}, 3, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(c)
        end))

    awful.titlebar(c):setup{
      { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout = wibox.layout.fixed.horizontal
      },
      { -- Middle
        { -- Title
          align = "center",
          widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout = wibox.layout.flex.horizontal
      },
      { -- Right
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    }
  end)
