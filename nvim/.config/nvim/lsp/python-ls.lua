local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require'lspconfig'.pyright.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '-f', function() vim.cmd('Neoformat black') end, { desc = '[F]ormat buffer' })
    end
}


-- vim.cmd [[ autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = false, timeout_ms = 100 }) ]]
-- vim.cmd [[ autocmd BufWritePre *.py Neoformat black ]]
