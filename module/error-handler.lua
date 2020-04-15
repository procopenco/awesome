-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if _G.awesome.startup_errors then _G.log.error(_G.awesome.startup_errors, "Oops, there were errors during startup!") end

-- Handle runtime errors after startup
do
  local in_error = false
  _G.awesome.connect_signal(
    "debug::error", function(err)
      -- Make sure we don't go into an endless error loop
      if in_error then return end
      in_error = true

      _G.log.error(tostring(err), "Oops, an error happened!")

      in_error = false
    end)
end
