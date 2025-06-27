local awful = require("awful")
local beautiful = require("beautiful")
beautiful.init(string.format("%s/.config/awesome/themes/theme.lua", os.getenv("HOME")))
local menubar = require("menubar")

local quitmenu = {}
-- {{{ Helper function for quitmenu
quitmenu.menu = {
    { "log out", function() awesome.quit() end, menubar.utils.lookup_icon("system-log-out") },
    { "suspend", "systemctl suspend", menubar.utils.lookup_icon("system-suspend") },
    { "hibernate", "systemctl hibernate", menubar.utils.lookup_icon("system-suspend-hibernate") },
    { "reboot", "systemctl reboot", menubar.utils.lookup_icon("system-reboot") },
    { "shutdown", "poweroff", menubar.utils.lookup_icon("system-shutdown") }
}
quitmenu.theme={
  border_width=2,
  border_color="#16A085",
  height=48,
  width=200,
  font="sans bold 16",
  bg_focus = beautiful.bg_focus,
  bg_normal = beautiful.bg_normal
}
quitmenu.popup = awful.menu({items=quitmenu.menu,theme=quitmenu.theme})
function quitmenu.show()
  s = awful.screen.focused()
  m_coords = {
    x = s.geometry.x + s.workarea.width/2 - quitmenu.theme.width/2,
    y = s.geometry.y + s.workarea.height/2- quitmenu.theme.height * #quitmenu.menu / 2
  }
  quitmenu.popup:show({coords=m_coords})
end
-- }}}

return quitmenu;
