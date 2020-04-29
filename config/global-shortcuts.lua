return function(config)
  local groups = config.shortcuts.groups
  local modkey = config.modkey

  return {
    help = {mod = {modkey}, key = "s", description = "show help popup", group = config.shortcuts.groups.general},
    reload = {mod = {modkey, "Control"}, key = "r", description = "reload awesome", group = groups.general},
    quit = {mod = {modkey, "Shift"}, key = "q", description = "quit awesome", group = groups.general},
    lock = {mod = {modkey}, key = "l", description = "lock screen", group = groups.general},
    emoji = {mod = {"Control"}, key = "space", description = "Emoji", group = groups.general},
    increase_volume = {mod = {}, key = "XF86AudioRaiseVolume", description = "increase volume", group = groups.general},
    decrease_volume = {mod = {}, key = "XF86AudioLowerVolume", description = "decrease volume", group = groups.general},
    toggle_volume = {mod = {}, key = "XF86AudioMute", description = "on/off volume", group = groups.general},
    increase_brightness = {
      mod = {},
      key = "XF86MonBrightnessUp",
      description = "increase brightness",
      group = groups.general,
    },
    decrease_brightness = {
      mod = {},
      key = "XF86MonBrightnessDown",
      description = "decrease brightness",
      group = groups.general,
    },
    smart_client_navigation = {
      mod = {modkey},
      key = "Tab",
      description = "smart client navigation",
      group = groups.client,
    },
    swap_with_next_client = {
      mod = {modkey, "Shift"},
      key = "Right",
      description = "swap with next client",
      group = groups.client,
    },
    swap_with_prev_client = {
      mod = {modkey, "Shift"},
      key = "Left",
      description = "swap with previous client",
      group = groups.client,
    },
    restore_minimized = {mod = {modkey, "Shift"}, key = "m", description = "restore minimized", group = groups.client},
    launch_terminal = {mod = {modkey}, key = "Return", description = "open a terminal", group = groups.launcher},
    launch_menu = {mod = {modkey}, key = "p", description = "show the menubars", group = groups.launcher},
  }
end
