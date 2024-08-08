local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

function disable_lsp_watcher()
    local ok, wf = pcall(require, "vim.lsp._watchfiles")
    if ok then
        -- disable lsp watcher. Too slow on linux
        wf._watchfunc = function()
            return function()
            end
        end
    end
end

require 'lspconfig'.pyright.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '-f', function() vim.cmd('Neoformat ruff') end, { desc = '[F]ormat buffer' })
        disable_lsp_watcher()
    end
}


-- vim.cmd [[ autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = false, timeout_ms = 100 }) ]]
-- vim.cmd [[ autocmd BufWritePre *.py Neoformat black ]]
