local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local variables = require("variables")

local cpu_perc = wibox.widget.textbox(' 00% ')
local cpu_t = awful.tooltip { }
local cpu_icon = 'P: '

cpu_t:add_to_object(cpu_perc)

awesome.connect_signal("evil::cpu", function(value)
  cpu_perc.markup = string.format('%02d%%', value)
  if value > 80 then
	  cpu:UpdateIcon(cpu_icon, beautiful.bg_urgent)
  else
	  cpu:UpdateIcon(cpu_icon, beautiful.fg_normal)
  end
end)

cpu_perc:connect_signal('mouse::enter', function()
	cpu_t.text = "Right click to open monitor"
end)

cpu = build_widget:new(cpu_perc, cpu_icon, beautiful.fg_normal)

cpu.widget:buttons(awful.util.table.join(
  awful.button({}, 3, function() 
	io.popen(terminal .. " -e gotop");
  end)
))

return cpu.widget
