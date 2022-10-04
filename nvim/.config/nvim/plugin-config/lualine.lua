require('lualine').setup({
    options = { theme = 'onedark'}
})

require("bufferline").setup({
    options = {
        numbers = "buffer_id",
        close_command = nil,
        right_mouse_command = nil,
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        diagnostics = "nvim_lsp",
    }
})
