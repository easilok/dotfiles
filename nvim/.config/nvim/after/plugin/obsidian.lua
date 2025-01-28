local obsidian = require("obsidian")
local base_dir = "~/Nextcloud/Obsidian"

if vim.fn.isdirectory(vim.fn.expand(base_dir)) ~= 0 then
    obsidian.setup({
        workspaces = {
            {
                name = "work",
                path = base_dir .. "/Work",
            },
            {
                name = "personal",
                path = base_dir .. "/Personal",
            },
            {
                name = "knowledge",
                path = base_dir .. "/Knowledge",
                overrides = {
                    templates = {
                        folder = "99 - Templates",
                        date_format = "%Y-%m-%d",
                        time_format = "%H:%M",
                    },
                }
            },
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
        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },
        preferred_link_style = "markdown",
        disable_frontmatter = true,
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
-- else
--     vim.notify("Could not find Obsidian workspace folder", vim.log.levels.INFO)
end
