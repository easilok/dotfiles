local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

local available_models = {
    "google/gemini-2.5-pro",
    "google/gemini-2.5-flash-preview-05-20",
    "anthropic/claude-sonnet-4",
    "anthropic/claude-3.7-sonnet",
    "openai/gpt-4o-mini",
}
local current_model = "openai/gpt-4o-mini"

local function select_model()
    vim.ui.select(available_models, {
        prompt = "Select  Model:",
    }, function(choice)
        if choice then
            current_model = choice
            vim.notify("Selected model: " .. current_model)
        end
    end)
end

codecompanion.setup({
    -- Integration with other plugins
    telescope_integration = true, -- Enable Telescope integration
    lsp_integration = true,     -- Enhance with LSP context
    -- Strategies
    strategies = {
        chat = {
            adapter = "anthropic",
            model = "claude-sonnet-4-20250514",
            -- keymaps = {
            --     submit = {
            --         modes = { n = '<CR>' },
            --         description = 'Submit',
            --         callback = function(chat)
            --             chat:apply_model(current_model)
            --             chat:submit()
            --         end,
            --     },
            -- },
        },
        inline = {
            adapter = "anthropic",
            model = "claude-sonnet-4-20250514",
        },
    },
    -- Custom Adapters
    adapters = {
        openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                    url = "https://openrouter.ai/api",
                    api_key = "OPENROUTER_API_KEY",
                    chat_url = "/v1/chat/completions",
                },
                schema = {
                    model = {
                        default = current_model,
                    },
                },
            })
        end,
    },
})


vim.keymap.set('n', '<space>cc', ':CodeCompanionChat toggle<CR>', { desc = 'Toggle CodeCompanion' })
vim.keymap.set('v', '<space>ca', ':CodeCompanionAsk<CR>', { desc = 'Ask about selected code' })
vim.keymap.set('v', '<space>cr', ':CodeCompanionReview<CR>', { desc = 'Review selected code' })
vim.keymap.set('v', '<space>ct', ':CodeCompanionTest<CR>', { desc = 'Generate tests for selected code' })
vim.keymap.set('n', '<space>cf', ':CodeCompanionFix<CR>', { desc = 'Fix problems in current buffer' })
vim.keymap.set('n', '<space>cm', select_model, { desc = 'Select Openrouter module' })

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
