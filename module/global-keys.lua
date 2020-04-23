local gears = require("gears")
local awful = require("awful")
local config = require("config")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

local globalkeys = gears.table.join( --          awful.key(
  --            {modkey}, "Tab", function() end, function()
  -- keygrabber.run(
  --   function(mods, key, action)
  --     log.info("hi2" .. key)
  --     print("You did:", gears.debug.dump_return(mods), key, action)
  --     keygrabber.stop()
  --   end)
  -- end),
                     awful.key(
                       {config.modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}
                     ), awful.key(
                       {config.modkey}, "Tab", function(a, b)
      awful.client.focus.byidx(1)
    end, {description = "focus next by index", group = "client"}
                     ), awful.key(
                       {config.modkey}, "Right", function()
      awful.client.focus.byidx(1)
    end, {description = "focus next by index", group = "client"}
                     ), awful.key(
                       {config.modkey}, "Left", function()
      awful.client.focus.byidx(-1)
    end, {description = "focus previous by index", group = "client"}
                     ), awful.key(
                       {config.modkey, "Shift"}, "Right", function()
      awful.client.swap.byidx(1)
    end, {description = "swap with next client by index", group = "client"}
                     ), awful.key(
                       {config.modkey, "Shift"}, "Left", function()
      awful.client.swap.byidx(-1)
    end, {description = "swap with previous client by index", group = "client"}
                     ), awful.key(
                       {config.modkey, "Control"}, "j", function()
      awful.screen.focus_relative(1)
    end, {description = "focus the next screen", group = "screen"}
                     ), awful.key(
                       {config.modkey, "Control"}, "k", function()
      awful.screen.focus_relative(-1)
    end, {description = "focus the previous screen", group = "screen"}
                     ), awful.key(
                       {config.modkey}, "u", awful.client.urgent.jumpto,
                       {description = "jump to urgent client", group = "client"}
                     ), awful.key(
                       {config.modkey}, "Return", function()
      awful.spawn(config.terminal)
    end, {description = "open a terminal", group = "launcher"}
                     ), awful.key(
                       {config.modkey, "Control"}, "r", awesome.restart,
                       {description = "reload awesome", group = "awesome"}
                     ), awful.key(
                       {config.modkey, "Shift"}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}
                     ), awful.key(
                       {config.modkey}, "l", function()
      awful.spawn("i3lock-fancy")
    end, {description = "lock screen", group = "awesome"}
                     ), awful.key(
                       {"Control"}, "space", function()
      awful.spawn("ibus emoji")
    end, {description = "Emoji", group = "awesome"}
                     ), awful.key(
                       {}, "XF86AudioRaiseVolume", function()
      awful.util.spawn("amixer set Master 5%+")
    end
                     ), awful.key(
                       {}, "XF86AudioLowerVolume", function()
      awful.util.spawn("amixer set Master 5%-")
    end
                     ), awful.key(
                       {}, "XF86AudioMute", function()
      awful.util.spawn("amixer sset Master toggle")
    end
                     ), awful.key(
                       {config.modkey, "Control"}, "n", function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal("request::activate", "key.unminimize", {raise = true})
      end
    end, {description = "restore minimized", group = "client"}
                     ), -- Prompt
  awful.key(
                       {config.modkey}, "r", function()
      awful.screen.focused().promptbox:run()
    end, {description = "run prompt", group = "launcher"}
                     ), awful.key(
                       {config.modkey}, "x", function()
      awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().promptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval",
      }
    end, {description = "lua execute prompt", group = "awesome"}
                     ), -- Menubar
  awful.key(
                       {config.modkey}, "p", function()
      menubar.show()
    end, {description = "show the menubar", group = "launcher"}
                     )
                   )

_G.root.keys(globalkeys)
