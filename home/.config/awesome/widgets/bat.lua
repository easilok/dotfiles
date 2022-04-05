local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local build_widget = require("widgets.build_widget")


local bat_perc = wibox.widget.textbox('00%')

local bat_icon = ""
local bat_icon_color = beautiful.xcolor12
local bat_text_color = beautiful.fg_normal

local bat_value_update = function (value, color)
  if (color == nil) then
    color = bat_text_color
  end
  bat_perc.markup = '<span color="' .. color ..'">' .. value ..'%</span>'
end

awesome.connect_signal("evil::charger", function(plugged)
  if plugged then
    bat_text_color = bat_icon_color
  else
    bat_text_color = beautiful.fg_normal
  end
end)


awesome.connect_signal("evil::battery", function(value)
  local bat_now = value

  if bat_icon ~= "A" and bat_now >= 90 then
    bat_icon = "A"
    bat_warning = false
  elseif bat_icon ~= "A" and bat_now < 90 and bat_now >= 60 then
    bat_icon = "A"
    bat_warning = false
  elseif bat_icon ~= "A" and bat_now < 60 and bat_now >= 20 then
    bat_icon = "A"
    bat_warning = false
  elseif bat_icon ~= "A" and bat_now < 20 then
    bat_icon = "A"
    bat_warning = true
  end

  if bat_warning and bat_icon_color ~= "red" then
    bat_icon_color = beautiful.xcolor1
  elseif not bat_warning and bat_icon_color ~= "#0883ff" then
    bat_icon_color = beautiful.xcolor12
  end

  bat_value_update(value, bat_text_color)
  bat:UpdateIcon(bat_icon, bat_icon_color)
end)

bat = build_widget:new(bat_perc, bat_icon, bat_icon_color)

return bat.widget
