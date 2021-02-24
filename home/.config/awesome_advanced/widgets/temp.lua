local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local temp_perc = wibox.widget.textbox('00°C')

awesome.connect_signal("evil::temperature", function(value)
  temp_perc.markup = string.format('%0d°C', value)
end)

temp = build_widget:new(temp_perc, '', beautiful.xcolor9)

return temp.widget
