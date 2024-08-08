-- Set up lspconfig.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '-f', function() vim.cmd('Neoformat prettier') end, { desc = '[F]ormat buffer' })
    end
}
-- npm install -g vls
-- require'lspconfig'.vuels.setup{
--     capabilities = capabilities
-- }
-- vim.cmd [[ autocmd BufWritePre *.vue lua vim.lsp.buf.format({async = true}) ]]

-- npm install -g @volar/vue-language-server
require'lspconfig'.volar.setup{
    capabilities = capabilities,
    filetypes = {'vue'},
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '-f', function() vim.cmd('Neoformat prettier') end, { desc = '[F]ormat buffer' })
    end
}

