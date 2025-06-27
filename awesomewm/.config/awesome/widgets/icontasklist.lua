local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    layout   = {
        spacing_widget = {
            {
                forced_width  = 5,
                forced_height = 24,
                thickness     = 1,
                color         = '#777777',
                widget        = wibox.widget.separator
            },
            valign = 'center',
            halign = 'center',
            widget = wibox.container.place,
        },
        spacing = 1,
        layout  = wibox.layout.fixed.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        {
            wibox.widget.base.make_widget(),
            forced_height = 5,
            id            = 'background_role',
            widget        = wibox.container.background,
        },
        {
            awful.widget.clienticon,
            margins = 5,
            widget  = wibox.container.margin
        },
        nil,
        layout = wibox.layout.align.vertical,
    },
}


awesome.connect_signal("evil::cpu", function(value)
  cpu_perc.markup = string.format('%02d%%', value)
end)

icontasklist = build_widget:new(cpu_perc, '', beautiful.fg_normal)

return icontasklist.widget
