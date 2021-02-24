local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local temp_perc = wibox.widget.textbox('00°C')
local temp_icon = ''

awesome.connect_signal("evil::temperature", function(value)
  temp_perc.markup = string.format('%0d°C', value)
  if value > 65 then
	temp:UpdateIcon(temp_icon, beautiful.bg_urgent)
  else
	temp:UpdateIcon(temp_icon, beautiful.fg_normal)
  end
end)

temp = build_widget:new(temp_perc, temp_icon, beautiful.fg_normal)

return temp.widget
