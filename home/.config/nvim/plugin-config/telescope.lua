require("telescope").setup({
	defaults = {
		-- file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = " >",
		color_devicons = true,

		-- mappings = {
		-- },
	},
	-- extensions = { },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("harpoon")
-- require('telescope').load_extension('file_browser')

-- vim.api.nvim_set_keymap("n", "<leader>fb", telescope.builtin.current_buffer_fuzzy_find, { sorting_strategy=ascending, prompt_position=top})
