require'lspconfig'.pyright.setup{}


vim.cmd [[ autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100) ]]
