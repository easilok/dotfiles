local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

codecompanion.setup({
    strategies = {
        chat = {
            adapter = "anthropic",
        },
        inline = {
            adapter = "anthropic",
        },
    },
})


-- vim.keymap.set('n', '<leader>cc', ':CodeCompanionToggle<CR>', { desc = 'Toggle CodeCompanion' })
-- vim.keymap.set('v', '<leader>ca', ':CodeCompanionAsk<CR>', { desc = 'Ask about selected code' })
-- vim.keymap.set('v', '<leader>cr', ':CodeCompanionReview<CR>', { desc = 'Review selected code' })
-- vim.keymap.set('v', '<leader>ct', ':CodeCompanionTest<CR>', { desc = 'Generate tests for selected code' })
-- vim.keymap.set('n', '<leader>cf', ':CodeCompanionFix<CR>', { desc = 'Fix problems in current buffer' })

-- require('codecompanion').setup({
--   window = {
--     width = 0.4,           -- 40% of editor width
--     height = 0.6,          -- 60% of editor height
--     border = "rounded",    -- Border style
--     position = "right",    -- Position: right, left, top, bottom
--   },
--   context = {
--     max_tokens = 4000,     -- Maximum context to send
--     include_imports = true, -- Include import statements
--     include_buffers = 2,   -- Number of related buffers to include
--   },
--   auto_close = false,      -- Keep the window open after response
--   language_detection = true, -- Automatically detect language
--   custom_instructions = "You are an AI programming assistant named CodeCompanion. You help with programming tasks in a concise manner.",
--   polling_interval = 500,  -- Milliseconds between API checks
--   smart_history = true,    -- Group related conversations
-- })
-- -- Define custom commands for specific tasks
-- vim.api.nvim_create_user_command("CCRefactor", function()
--   require('codecompanion').ask_with_context("Refactor this code for better readability and performance")
-- end, {})

-- -- Integration with other plugins
-- require('codecompanion').setup({
--   telescope_integration = true, -- Enable Telescope integration
--   lsp_integration = true,      -- Enhance with LSP context
-- })
