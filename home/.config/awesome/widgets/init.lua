local awful = require('awful')
local wibox = require('wibox')
local build_widget = require('widgets.build_widget')
beautiful = require('beautiful')

local widgets = {}

-- From Files
widgets.cpu = require('widgets.cpu')
widgets.mem = require('widgets.mem')
widgets.temp = require('widgets.temp')
widgets.disk = require('widgets.disk')
widgets.vol = require('widgets.vol')
-- widgets.bat = require('widgets.bat')
widgets.mpd = require('widgets.mpd')
widgets.kblayout = require('widgets.kblayout')
-- widgets.archupdates = require('widgets.archupdates')
widgets.clientcount = require('widgets.clientcount')
-- widgets.icontasklist = require('widgets.icontasklist')
widgets.mail = require('widgets.mail')
local battery_widget = require('widgets.battery-widget')
widgets.battery = battery_widget { adapter = "BAT0", ac = "AC" }

-- Separators
widgets.space = wibox.widget.textbox('<span>  </span>')
widgets.separator = wibox.widget.textbox(string.format(' <span color="%s">|</span>  ', beautiful.fg_normal))

widgets.textclock = require('widgets.textclock')

widgets.outlook_event = require('widgets.outlook_event')

return widgets
