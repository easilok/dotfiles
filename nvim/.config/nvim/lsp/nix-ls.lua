-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- require'lspconfig'.nixd.setup{
--     capabilities = capabilities,
--     filetypes = {'nix'},
-- }

vim.lsp.enable('nixd')
