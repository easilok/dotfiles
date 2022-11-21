local action_layout = require('telescope.actions.layout')

require("telescope").setup({
	defaults = {
		-- file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = " >",
		color_devicons = true,
        layout_strategy = 'vertical',
        layout_config = {
            vertical = {
                width = 0.8,
                -- prompt_position = "top",
            }
        },
		mappings = {
            i = {
                ["<C-t>"] = action_layout.cycle_layout_next,
            },
            n = {
                ["<C-t>"] = action_layout.cycle_layout_next,
            }
		},
	},
	-- extensions = { },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("harpoon")
-- require('telescope').load_extension('file_browser')

-- vim.api.nvim_set_keymap("n", "<leader>fb", telescope.builtin.current_buffer_fuzzy_find, { sorting_strategy=ascending, prompt_position=top})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fb', function() builtin.current_buffer_fuzzy_find({sorting_strategy="ascending"}) end, {})
vim.keymap.set('n', '<leader>gl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gs', function() builtin.grep_string( { search = vim.fn.input("Grep For > ")} ) end, {})
vim.keymap.set('n', '<leader>gw', function() builtin.grep_string( { search = vim.fn.expand("<cword>") } ) end, {})
vim.keymap.set('n', '<leader>bl', builtin.buffers, {})
vim.keymap.set('n', '<leader>ge', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>ga', ":Telescope harpoon marks<cr>", {})
