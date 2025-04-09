require('render-markdown').setup( {
    pipe_table = {
        enabled = false
    }
})

local markdown_table_format = function()
    vim.cmd('Tabularize\\|')
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(event)
        vim.api.nvim_create_user_command('TabFormat', markdown_table_format, {})

        vim.keymap.set("n", "<space>mt", markdown_table_format, { desc = "[M]arkdown [T]able format" })
        vim.keymap.set("v", "<space>mt", markdown_table_format, { desc = "[M]arkdown [T]able format" })
    end,
})
