local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
beautiful.init(string.format("%s/.config/awesome/themes/theme.lua", os.getenv("HOME")))

local variables = require("variables")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "telegram-desktop",
          "TelegramDesktop",
          "xtightvncviewer",
          "skype",
          "Skype",
          "Xfce-appfinder",
          "mpv",
          "vlc",
      },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    -- { rule_any = {type = { "normal", "dialog" }
    --   }, properties = { titlebars_enabled = false }
    -- },
    -- Keep dialogs on top
    {
	  rule_any = {
        class = {"file_progress", },
        type = { "dialog" },
      },
      properties = { ontop = true, },
    },


    -- Set Firefox to always map on the tag named "2" on screen 1.
    {
        rule_any = { 
            class = {"Firefox", "firefox", "qutebrowser", "Qutebrowser", "brave-browser", "Brave-browser", "Librewolf" },
        },
        properties = { tag = tagnames[4] } 
    },
    {
        rule_any = { 
            class = {"pcmanfm", "Pcmanfm"},
        },
        properties = { tag = tagnames[6] } 
    },
    {
        rule_any = { 
            class = {"remmina", "Remmina"},
        },
        properties = { screen = 1, tag = tagnames[7] } 
    },
    { 
        rule_any = { 
            class = {"Microsoft Teams - Preview", "teams-for-linux"},
        },
        properties = { screen = 1, tag = tagnames[5] } 
    },
}
