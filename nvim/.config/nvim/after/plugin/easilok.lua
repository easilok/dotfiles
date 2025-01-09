require "easilok"

local headster = require "easilok.headster"
local headster_root = "~/.headster"
if vim.fn.isdirectory("~/Nextcloud/headster") ~= 0 then
    headster_root = "~/Nextcloud/headster"
end

headster.setup({ root_path = headster_root })

vim.keymap.set('n', '<space>hc', headster.capture, { desc = "[H]eadester [C]apture" })
