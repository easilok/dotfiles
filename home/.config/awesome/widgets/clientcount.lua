local awful = require("awful")
local wibox = require("wibox")
local build_widget = require("widgets.build_widget")

local variables = require("variables")

local clients = wibox.widget.textbox(' 1: ')
local clients_icon = ''

function updateClients()

	local t = awful.screen.focused().selected_tag
	if not t then return -1 end
	local clientTable = t:clients()
	return #clientTable

end

screen.connect_signal("tag::history::update", function(value)
	local count=updateClients()
	if count >= 0 then
		clients.markup = count .. ": "
	end
end)

client.connect_signal("list", function(value)
	local count=updateClients()
	if count >= 0 then
		clients.markup = count .. ": "
	end
end)

clientcount = build_widget:new(clients, clients_icon, beautiful.fg_normal)

clientcount.widget:buttons(awful.util.table.join(
	awful.button({ }, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end)
))

return clientcount.widget
