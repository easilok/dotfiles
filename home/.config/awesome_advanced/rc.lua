local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local utils = require("utils")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

local keys = require("keys")
local rules = require("rules")
local variables = require("variables")

beautiful.init(string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME")))

require("evil")
local widgets = require("widgets")
awful.util.terminal = terminal

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
  text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
    text = tostring(err) })
    in_error = false
  end)
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
                  menu_awesome,
                  { "Debian", debian.menu.Debian_menu.Debian },
                  menu_terminal,
                }
    })
end


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
-- }}}
--
-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    awful.spawn.with_shell('nitrogen --restore')
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
  -- Tags
  --awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
  for _, i in pairs(awful.util.tagnames[s.index]) do
    awful.tag.add(i.name, {
      layout = i.lay or awful.layout.layouts[1],
      gap = i.gap or beautiful.useless_gap,
      gap_single_client = not i.sgap,
      screen = s,
      selected = i.sel or false,
      master_width_factor = i.mw or 0.5,
    })
  end

  -- Create a promptbox for each screen
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 2, function() awful.layout.set( awful.layout.layouts[1] ) end),
    awful.button({}, 4, function() awful.layout.inc( 1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused)

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = 19 })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      s.mytaglist,
      s.mypromptbox,
      widgets.seperator,
      -- widgets.mpd,
    },
      -- wibox.container.place(widgets.textclock, "center"),
      s.mytasklist,
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      id = "rightwidgets",
      -- widgets.kblayout,
      widgets.temp,
      widgets.disk,
      seperator,
      widgets.cpu,
      widgets.mem,
      widgets.vol,
      widgets.bat,
      widgets.space,
      seperator,
      wibox.widget.systray(),
      seperator,
      -- widgets.textclock,
      mytextclock,
    },
  }
end)
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Start the new client as slave.
  if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and
  not c.size_hints.user_position
  and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c, {honor_padding = true})
  end
end)


-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--   c:emit_signal("request::activate", "mouse_enter", {raise = true})
-- end)


-- Force minimized clients to unminimize.
client.connect_signal("property::minimized", function(c)
  c.minimized = false
end)


client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Autostart
-- for _, i in pairs(autostart) do
--  awful.spawn.with_shell("~/.config/awesome/autorun.sh " .. i)
-- end

awful.spawn.with_shell("~/.config/awesome/autorun.sh")
-- awful.spawn.with_shell("pulsemixer --unmute")

-- Quake terminal
-- quake = utils.quake {
--   app = terminal,
--   horiz = "center",
--   height = 0.4,
--   width = 0.9,
--   followtag = true,
--   border = 0
-- }

