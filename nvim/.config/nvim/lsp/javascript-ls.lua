  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '<space>f', function() vim.cmd('Neoformat prettier') end, bufopts)
    end
}
-- npm install -g vls
require'lspconfig'.vuels.setup{
    capabilities = capabilities
}
vim.cmd [[ autocmd BufWritePre *.vue lua vim.lsp.buf.format({async = true}) ]]

