require("module.client.history")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local config = require("config")
local beautiful = require("beautiful")
local shortcut_utils = require("utils.shortcut")
local add_key = shortcut_utils.add_key
local client_shortcuts = config.shortcuts.client

local function toggle_fullscreen_handler(client)
  client.fullscreen = not client.fullscreen
  client:raise()
end

local function close_client_handler(client)
  client:kill()
end

local function keep_on_top_handler(client)
  client.ontop = not client.ontop
end

local function minimize_handler(client)
  client.minimized = true
end

local function maximize_handler(client)
  local screen_size = client.screen.workarea
  local relative_x = screen_size.x - client.x
  local relative_y = screen_size.y - client.y
  local relative_width = screen_size.width - client.width
  local relative_height = screen_size.height - client.height

  client:relative_move(relative_x, relative_y, relative_width, relative_height)
end

local function move_to_left_handler(client)
  local screen_size = client.screen.workarea
  local relative_x = screen_size.x - client.x
  local relative_y = screen_size.y - client.y
  local relative_width = screen_size.width / 2 - client.width
  local relative_height = screen_size.height - client.height

  client:relative_move(relative_x, relative_y, relative_width, relative_height)
end

local function move_to_right_handler(client)
  local screen_size = client.screen.workarea
  local relative_x = screen_size.width / 2 + screen_size.x - client.x
  local relative_y = screen_size.y - client.y
  local relative_width = screen_size.width / 2 - client.width
  local relative_height = screen_size.height - client.height

  client:relative_move(relative_x, relative_y, relative_width, relative_height)
end

local clientkeys = gears.table.join(
                     add_key(client_shortcuts.fullscreen, toggle_fullscreen_handler),
                     add_key(client_shortcuts.close, close_client_handler),
                     add_key(client_shortcuts.ontop, keep_on_top_handler),
                     add_key(client_shortcuts.minimize, minimize_handler),
                     add_key(client_shortcuts.maximize, maximize_handler),
                     add_key(client_shortcuts.move_to_left, move_to_left_handler),
                     add_key(client_shortcuts.move_to_right, move_to_right_handler)
                   )

local clientbuttons = gears.table.join(
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
      maximized = false,
    },
  }, -- Floating clients.
  {rule_any = {type = {"normal", "dialog"}}, properties = {titlebars_enabled = true}},
}

_G.client.connect_signal(
  "manage", function(c)
    maximize_handler(c)

    if _G.awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
_G.client.connect_signal(
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
