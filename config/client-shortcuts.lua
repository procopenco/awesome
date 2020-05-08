return function(config)
  local groups = config.shortcuts.groups
  local modkey = config.modkey

  return {
    fullscreen = {mod = {modkey}, key = "f", description = "toggle fullscreen", group = groups.client},
    close = {mod = {modkey, "Shift"}, key = "c", description = "close", group = groups.client},
    ontop = {mod = {modkey}, key = "t", description = "toggle keep on top", group = groups.client},
    minimize = {mod = {modkey}, key = "m", description = "minimize", group = groups.client},
    maximize = {mod = {modkey}, key = "Up", description = "maximize", group = groups.client},
    move_to_left = {mod = {modkey}, key = "Left", description = "Place client to the left", group = groups.client},
    move_to_right = {mod = {modkey}, key = "Right", description = "Place client to the right", group = groups.client},
  }
end
