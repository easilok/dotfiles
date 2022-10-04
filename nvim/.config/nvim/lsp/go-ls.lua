require'lspconfig'.gopls.setup{
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    }
}

vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()]]
