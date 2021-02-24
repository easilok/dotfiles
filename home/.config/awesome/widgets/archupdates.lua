local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local variables = require("variables")

local archupdates_count = wibox.widget.textbox(' ')
local archupdates_t = awful.tooltip { }
local archupdates_warning_icon = ''
local archupdates_warning = '#ff9900'
local archupdates_ok_icon = ''
local archupdates_ok = beautiful.fg_normal

archupdates_t:add_to_object(archupdates_count)

awesome.connect_signal("evil::archupdates", function(value)
  -- archupdates.markup = string.format('%01d%%', value)
	if (value ~= nil) then
		if (value > 0) then
			archupdates:UpdateIcon(archupdates_warning_icon, archupdates_warning)
			archupdates_count.markup = value --string.format('%02d%%', value)
		else
			archupdates:UpdateIcon(archupdates_ok_icon, archupdates_ok)
			archupdates_count.markup = ''
		end
	end
end)

archupdates_count:connect_signal('mouse::enter', function()
	archupdates_t.text = "Right click to update"
end)

archupdates = build_widget:new(archupdates_count, archupdates_ok_icon, archupdates_ok)

archupdates.widget:buttons(awful.util.table.join(
  awful.button({}, 3, function() 
	io.popen(terminal .. " -e 'yay -Syu' ");
  end)
))

return archupdates.widget
