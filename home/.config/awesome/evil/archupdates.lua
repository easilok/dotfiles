-- Provides:
-- evil::archupdates
--      used quantity (integer)
local awful = require("awful")

local update_interval = 1200
local archupdates_idle_script = [[
  sh -c "
	$HOME/scripts/arch_update_count.sh 
  "]]

-- Periodically get cpu info
awful.widget.watch(archupdates_idle_script, update_interval, function(widget, stdout)
    local archupdates_idle = stdout
    awesome.emit_signal("evil::archupdates", tonumber(archupdates_idle))
end)
