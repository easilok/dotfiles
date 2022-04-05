local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local mail_count = wibox.widget.textbox('00')

local mail_script = [[
  bash -c "
    ~/.config/awesome/scripts/get-mail
  "
]]

awful.widget.watch(mail_script, 100, function(widget, stdout)
  mail_count.markup = stdout
end)

mail = build_widget:new(mail_count, '✉', beautiful.xcolor7)

return mail.widget
