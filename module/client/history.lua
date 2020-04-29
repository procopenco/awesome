local is_history_frozen = false
local clients_history_position = {}

local function find_client_position(client)
  for position, history_client in pairs(clients_history_position) do
    if history_client == client then
      return position
    end
  end

  return nil
end

local function remove_client(client)
  local position = find_client_position(client)
  if position ~= nil then
    table.remove(clients_history_position, position)
  end
end

local function focus_handler(client)
  if not is_history_frozen then
    remove_client(client)
    table.insert(clients_history_position, client)
  end
end

local history = {}

history.focus_next = function()
  log.info("next")
end

history.focus_prev = function()
  local prev_position = find_client_position(_G.client.focus) - 1
  if prev_position == 0 then
    prev_position = #clients_history_position
  end

  local client = clients_history_position[prev_position]
  _G.client.focus = client
  client:raise()
end

history.freeze = function()
  is_history_frozen = true
end

history.unfreeze = function()
  is_history_frozen = false
  focus_handler(_G.client.focus)
end

local function manage_handler(client)
  client.smart_history = history
end

local function unmanage_handler(client)
  remove_client(client)
end

_G.client.connect_signal("focus", focus_handler)

_G.client.connect_signal("manage", manage_handler)
_G.client.connect_signal("unmanage", unmanage_handler)
