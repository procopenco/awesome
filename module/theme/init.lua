local beautiful = require("beautiful")
local config = require("config")

---------------------------
-- Default awesome theme --
---------------------------
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local old_themes_path = "~/.config/awesome/themes/"
local assets_dir = config.root_dir .. "module/theme/assets/"

local theme = {}

theme.font = "Roboto medium 8"

theme.bg_normal = "#222222"
theme.bg_focus = "#535d6c"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(0)
theme.border_width = dpi(1)
theme.border_normal = "#000000"
theme.border_focus = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = old_themes_path .. "my/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = old_themes_path .. "my/titlebar/close_normal.png"
theme.titlebar_close_button_focus = old_themes_path .. "my/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = old_themes_path .. "my/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = old_themes_path .. "my/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = old_themes_path .. "my/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = old_themes_path .. "my/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = old_themes_path .. "my/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = old_themes_path .. "my/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = old_themes_path .. "my/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = old_themes_path .. "my/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = old_themes_path .. "my/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = old_themes_path .. "my/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = old_themes_path .. "my/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = old_themes_path .. "my/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = old_themes_path .. "my/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = old_themes_path .. "my/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = old_themes_path .. "my/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = old_themes_path .. "my/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = old_themes_path .. "my/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = old_themes_path .. "my/titlebar/maximized_focus_active.png"

theme.wallpaper = assets_dir .. "wallpaper.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = old_themes_path .. "my/layouts/fairhw.png"
theme.layout_fairv = old_themes_path .. "my/layouts/fairvw.png"
theme.layout_floating = old_themes_path .. "my/layouts/floatingw.png"
theme.layout_magnifier = old_themes_path .. "my/layouts/magnifierw.png"
theme.layout_max = old_themes_path .. "my/layouts/maxw.png"
theme.layout_fullscreen = old_themes_path .. "my/layouts/fullscreenw.png"
theme.layout_tilebottom = old_themes_path .. "my/layouts/tilebottomw.png"
theme.layout_tileleft = old_themes_path .. "my/layouts/tileleftw.png"
theme.layout_tile = old_themes_path .. "my/layouts/tilew.png"
theme.layout_tiletop = old_themes_path .. "my/layouts/tiletopw.png"
theme.layout_spiral = old_themes_path .. "my/layouts/spiralw.png"
theme.layout_dwindle = old_themes_path .. "my/layouts/dwindlew.png"
theme.layout_cornernw = old_themes_path .. "my/layouts/cornernww.png"
theme.layout_cornerne = old_themes_path .. "my/layouts/cornernew.png"
theme.layout_cornersw = old_themes_path .. "my/layouts/cornersww.png"
theme.layout_cornerse = old_themes_path .. "my/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

beautiful.init(theme)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
