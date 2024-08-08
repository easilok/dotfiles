local obsidian = require("obsidian")

obsidian.setup({
    workspaces = {
        {
            name = "work",
            path = "~/Nextcloud/Obsidian/Work",
        },
        {
            name = "personal",
            path = "~/Nextcloud/Obsidian/Personal", },
    },
    daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "journal",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        default_tags = { "journal" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
    },
    mappings = {
        -- Toggle check-boxes.
        ["<space>ch"] = {
            action = function()
                return obsidian.util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
    }
})


vim.keymap.set("", "<space>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "Switch [O]bsidian [W]orkspace" })
vim.keymap.set("", "<space>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Switch [O]bsidian [Q]uick Switch" })
vim.keymap.set("", "<space>og", "<cmd>ObsidianSearch<CR>", { desc = "Switch [O]bsidian Search" })
