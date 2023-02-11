local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local outlook_event_tb = wibox.widget.textbox('')
local outlook_event_tooltip = awful.tooltip { }

outlook_event_tooltip:add_to_object(outlook_event_tb)

local outlook_events_script = [[
  bash -c "
    cat /tmp/next_event || echo No Outlook events
  "
]]

awful.widget.watch(outlook_events_script, 300, function(widget, stdout)
  outlook_event_tb.markup = stdout
end)

outlook_event = build_widget:new(outlook_event_tb, '', beautiful.fg_normal)

outlook_event_tb:connect_signal('mouse::enter', function()
	outlook_event_tooltip.text = "Right click to open login page"
end)

outlook_event.widget:buttons(awful.util.table.join(
  awful.button({}, 3, function() 
	-- io.popen(terminal .. " -e gotop");
    os.execute("open http://localhost:8000/home")
  end)
))
return outlook_event.widget
