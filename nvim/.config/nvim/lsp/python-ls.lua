require'lspconfig'.pyright.setup{}


vim.cmd [[ autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = false, timeout_ms = 100 }) ]]
