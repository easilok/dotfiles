local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function build_icon (icon)
  return string.format('<span color="%s" font="%s">%s</span> ',
    beautiful.fg_normal, beautiful.iconFont, icon)
end

local mpd_play = wibox.widget.textbox(build_icon(' '))
local mpd_song = wibox.widget.textbox('')
local mpd_prev = wibox.widget.textbox('')
local mpd_next = wibox.widget.textbox('')

awesome.connect_signal("evil::mpd", function(artist, title, status)
  if status == "paused" or status == "playing" then
    mpd_prev.markup = build_icon('')
    mpd_next.markup = build_icon('')
    mpd_song.markup = string.format('<span font="%s" color="%s">%s</span> - <span color="%s">%s</span>',
      beautiful.taglist_font, beautiful.xcolor15, artist, beautiful.xcolor10, title)
      if status == "playing" then
        mpd_play.markup = build_icon('')
      else
        mpd_play.markup = build_icon('')
      end
  else
    mpd_prev.markup, mpd_next.markup, mpd_song.markup = '', '', ''
    mpd_play.markup = build_icon(' ')
  end
end)

mpd_play:buttons(awful.util.table.join(
  awful.button({}, 1, function()
    os.execute("mpc toggle")
  end),
  awful.button({}, 3, function()
    os.execute("mpc stop")
  end)
))

mpd_prev:buttons(awful.util.table.join(
  awful.button({}, 1, function()
    os.execute("mpc prev")
  end)
))

mpd_next:buttons(awful.util.table.join(
  awful.button({}, 1, function()
    os.execute("mpc next")
  end)
))

local mpd = wibox.widget{
  mpd_prev,
  mpd_play,
  mpd_next,
  mpd_song,
  layout = wibox.layout.fixed.horizontal
}

return mpd
