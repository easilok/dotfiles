require "easilok"
require "easilok.quit-confirm"

local headster = require "easilok.headster"
local headster_root = vim.fn.expand("~/.headster")
local headster_cloud = vim.fn.expand("~/Nextcloud/headster")
if vim.fn.isdirectory(headster_cloud) ~= 0 then
    headster_root = headster_cloud
end

headster.setup({ root_path = headster_root })

vim.keymap.set('n', '<space>hc', headster.capture, { desc = "[H]eadester [C]apture" })

