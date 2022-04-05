local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local variables = require("variables")

local mem_perc = wibox.widget.textbox('00%')
local mem_t = awful.tooltip { }
local mem_icon = 'M: '

mem_t:add_to_object(mem_perc)

awesome.connect_signal("evil::ram", function(used, total)
  local value = math.floor((used / total) * 100)
  mem_perc.markup = string.format('%0d%%', value)
  if value > 75 then
	  mem:UpdateIcon(mem_icon, beautiful.bg_urgent)
  else
	  mem:UpdateIcon(mem_icon, beautiful.fg_normal)
  end
end)

mem_perc:connect_signal('mouse::enter', function()
	mem_t.text = "Right click to open monitor"
end)

mem = build_widget:new(mem_perc, mem_icon, beautiful.fg_normal)

mem.widget:buttons(awful.util.table.join(
  awful.button({}, 1, function() 
	io.popen(terminal .. " -e gotop");
  end)
))

return mem.widget
