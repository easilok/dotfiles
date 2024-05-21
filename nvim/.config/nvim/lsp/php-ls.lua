-- https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation
require'lspconfig'.phpactor.setup{
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '-f', function() vim.cmd('Neoformat laravelpint') end, { desc = '[F]ormat buffer' })
    end
}

