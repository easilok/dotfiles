require("buffer_manager").setup({ })

vim.keymap.set("n", "<C-e>", require("buffer_manager.ui").toggle_quick_menu,
    { desc = "Buffer List Manager" })
