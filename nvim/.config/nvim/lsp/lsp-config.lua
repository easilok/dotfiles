
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

vim.diagnostic.config({
    virtual_text = false, -- default to true
    signs = true, -- default is true
    underline = true, -- default to true
    update_in_insert = false, -- default to false
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = 'Lsp Jumps to [D]efinition' })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = 'Lsp List [R]references to symbol' })

-- Convert to pure LSP
-- -- Show line diagnostics
vim.keymap.set("n", "<space>sl", vim.diagnostic.open_float, { desc = 'L[s]p [L]ine diagnostics'})

-- -- Show cursor diagnostics
-- -- Like show_line_diagnostics, it supports passing the ++unfocus argument
-- vim.keymap.set("n", "<space>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>",{ desc = 'Lsp [S]aga [C]ursor diagnostics'})

-- -- Diagnostic jump
-- -- You can use <C-o> to jump back to your previous location
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = 'Lsp Diagnostic previous'})
vim.keymap.set("n", "]e", vim.diagnostic.goto_next,{ desc = 'Lsp Diagnostic next'})


vim.keymap.set("n", "-k", vim.lsp.buf.hover, { desc = 'Lsp hover doc' })

vim.keymap.set("n", "<space>sh", vim.lsp.buf.signature_help, { desc = 'Lsp [S]ignature [H]elp'})



