-- latte, frappe, macchiato, mocha
vim.g.catppuccin_flavour = "mocha"

require("catppuccin").setup({
    transparent_background = true,
    integrations = {
        markdown = true,
        lsp_saga = true,
        treesitter_context = true,
        treesitter = true,
        telescope = true,
        gitgutter = true,
        vimwiki = true,
        which_key = true,
        cmp = true
    }
})

-- vim.cmd [[colorscheme catppuccin]]
