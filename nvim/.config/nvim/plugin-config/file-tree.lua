-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded = 1
-- vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
-- local nvim_tree = require("nvim-tree")
-- nvim_tree.setup( {
--   sort_by = "case_sensitive",
--   view = {
--     adaptive_size = true,
--     mappings = {
--       list = {
--         { key = "u", action = "dir_up" },
--       },
--     },
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = false,
--   },
-- })

-- vim.keymap.set('nivx', '<F6>', nvim_tree.toggle, {})
-- vim.keymap.set('n', '<F6>', nvim_tree.toggle, {})

require("neo-tree").setup()
vim.keymap.set('n', '<F6>', ":Neotree toggle<cr>" , {})

vim.cmd [[hi NvimTreeNormal guibg=NONE]]
vim.cmd [[hi NvimTreeNormalNC guibg=NONE]]
