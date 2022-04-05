local awful = require("awful")

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "termite"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
lockscreen = "betterlockscreen -l dim"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    awful.layout.suit.floating,
}
-- ws-icon-0 = "1:"
awful.util.tagnames = {
	{
		{name = "1.", sel = true},
		{name = "2."},
		{name = "3."},
		{name = "4.", lay = awful.layout.suit.max},
		{name = "5."},
		{name = "6."},
		{name = "7.", lay = awful.layout.suit.max},
		{name = "8."},
		{name = "9."},
		-- {name = "9"},
	},
	{
		{name = "1", sel = true},
		{name = "2"},
		{name = "3"},
		{name = "4"},
		{name = "5"},
		{name = "6"},
		{name = "7"},
		{name = "8"},
		{name = "9"},
	}
}

