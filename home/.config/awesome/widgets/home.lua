local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local home_perc = wibox.widget.textbox('00%')

local home_script = [[
  bash -c "
    df -k -h /home | tail -1 | awk '{print $5}'
  "
]]

awful.widget.watch(home_script, 1000, function(widget, stdout)
  home_perc.markup = stdout
end)

local home = build_widget:new(home_perc, 'H: ', beautiful.fg_normal)

return home.widget
