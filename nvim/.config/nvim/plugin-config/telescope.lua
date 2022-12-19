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
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [g]it files'})
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [f]iles'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [h]elp files'})
vim.keymap.set('n', '<leader>fb', function() builtin.current_buffer_fuzzy_find({sorting_strategy="ascending"}) end, { desc = '[F]ind [b]uffer text'})
vim.keymap.set('n', '<leader>gl', builtin.live_grep, { desc = '[G]rep [l]ive' })
vim.keymap.set('n', '<leader>gs', function() builtin.grep_string( { search = vim.fn.input("Grep For > ")} ) end, { desc = '[G]rep [s]earch' })
vim.keymap.set('n', '<leader>gw', function() builtin.grep_string( { search = vim.fn.expand("<cword>") } ) end, { desc = '[G]rep current [w]ord' })
vim.keymap.set('n', '<leader>bl', builtin.buffers, { desc = '[B]uffer [l]ist' })
vim.keymap.set('n', '<leader>ge', builtin.diagnostics, { desc = '[G]rep diagnostics' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = '[G]rep [r]eferences' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [b]ranches' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [c]ommits' })
vim.keymap.set('n', '<leader>ga', ":Telescope harpoon marks<cr>", { desc = '[G]rep h[a]rpoon marks' })
vim.keymap.set('n', '<space>lds', builtin.lsp_document_symbols, { desc = '[L]sp [D]ocument [S]ymbols' })
vim.keymap.set('n', '<space>lws', builtin.lsp_dynamic_workspace_symbols, {desc = '[L]sp [W]orkspace [S]ymbols' })
vim.keymap.set('n', '<space>tr', builtin.resume, { desc = '[T]elescope [r]esume' })
vim.keymap.set('n', '<space>tk', builtin.keymaps, { desc = '[T]elescope [k]eymaps' })
