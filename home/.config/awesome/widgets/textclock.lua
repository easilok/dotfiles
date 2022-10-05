local wibox = require("wibox")
local awful = require("awful")

local mytextclock = wibox.container.background(wibox.widget.textclock("%d/%b (W%V) - %H:%M"))
-- mytextclock.fg = "black"

local day_cell_properties = {
    border_width = 0,
    border_color = '#ffffff'
}

local month_calendar = awful.widget.calendar_popup.month({position="tr", week_numbers=true, style_normal = day_cell_properties})
month_calendar:attach( mytextclock, "tr", {on_hover = false})

return mytextclock
