return function(config)
  local groups = config.shortcuts.groups
  local modkey = config.modkey

  return {
    fullscreen = {mod = {modkey}, key = "f", description = "toggle fullscreen", group = groups.client},
    close = {mod = {modkey, "Shift"}, key = "c", description = "close", group = groups.client},
    ontop = {mod = {modkey}, key = "t", description = "toggle keep on top", group = groups.client},
    minimize = {mod = {modkey}, key = "m", description = "minimize", group = groups.client},
    maximize = {mod = {modkey}, key = "Up", description = "maximize", group = groups.client},
    unmaximize = {mod = {modkey}, key = "Down", description = "unmaximize", group = groups.client},
  }
end
