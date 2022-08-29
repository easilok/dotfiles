-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{}
-- npm install -g vls
require'lspconfig'.vuels.setup{}
vim.cmd [[ autocmd BufWritePre *.vue lua vim.lsp.buf.formatting_sync(nil, 100) ]]

