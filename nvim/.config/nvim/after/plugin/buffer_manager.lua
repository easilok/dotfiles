require("buffer_manager").setup({
    show_indicators = true,
    width = math.min(math.floor(vim.o.columns * 0.5), 100),
    height = math.min(math.floor(vim.o.lines * 0.5), 20),
})

vim.keymap.set("n", "<C-e>", require("buffer_manager.ui").toggle_quick_menu,
    { desc = "Buffer List Manager" })
