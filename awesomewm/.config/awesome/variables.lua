local awful = require("awful")

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "xterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
lockscreen = "betterlockscreen -l dim"

tagnames = {"1.", "2.", "3.", "4.", "5.", "6.", "7.", "8.", "9."}

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
        {name = tagnames[1], sel = true},
        {name = tagnames[2]},
        {name = tagnames[3]},
        {name = tagnames[4], lay = awful.layout.suit.max},
        {name = tagnames[5]},
        {name = tagnames[6]},
        {name = tagnames[7]},
        {name = tagnames[8]},
        {name = tagnames[9]},
    },
    {
        {name = tagnames[1], sel = true},
        {name = tagnames[2]},
        {name = tagnames[3]},
        {name = tagnames[4]},
        {name = tagnames[5]},
        {name = tagnames[6]},
        {name = tagnames[7]},
        {name = tagnames[8]},
        {name = tagnames[9]},
    }
}

