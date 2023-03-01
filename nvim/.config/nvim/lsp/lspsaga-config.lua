local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

-- saga.init_lsp_saga {
--   your custom option here
-- }

saga.init_lsp_saga()
require'lsp_signature'.on_attach({bind = false, use_lspsaga = true})

-- Code action
vim.keymap.set({"n","v"}, "<space>sa", "<cmd>Lspsaga code_action<CR>", { desc = 'Lsp [S]aga Code [A]ction' })

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { desc = 'Lsp Saga Peek [D]efinition' })
-- Rename all occurrences of the hovered word for the selected files
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>", { desc = 'Lsp Saga [R]ename in project' })

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
vim.keymap.set("n", "<space>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = 'Lsp [S]aga [L]ine diagnostics'})

-- Show cursor diagnostics
-- Like show_line_diagnostics, it supports passing the ++unfocus argument
vim.keymap.set("n", "<space>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>",{ desc = 'Lsp [S]aga [C]ursor diagnostics'})

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = 'Lsp Sage Diagnostic previous'})
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>",{ desc = 'Lsp Sage Diagnostic next'})


-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
vim.keymap.set("n", "<space>gk", "<cmd>Lspsaga hover_doc<CR>", { desc = 'Lsp [S]aga hover doc' })
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = 'Lsp [S]aga hover doc' })

vim.keymap.set("n", "<space>ss", "<cmd>Lspsaga signature_help<CR>", { desc = 'Lsp [S]aga [S]ignature Help'})

