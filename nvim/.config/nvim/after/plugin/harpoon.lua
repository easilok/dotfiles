local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>aa", function() harpoon:list():add() end, { desc = "H[a]rpoon [A]dd" })
vim.keymap.set("n", "<leader>tq", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "[T]oggle Harpoon [Q]uick Menu" })
vim.keymap.set("n", "<space>ha", function() harpoon:list():add() end, { desc = "[H]arpoon [A]dd" })
vim.keymap.set("n", "<space>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "[H]arpoon toggle [M]enu" })

vim.keymap.set("n", "<M-h>", function() harpoon:list():select(1) end, { desc = "Harpoon select 1" })
vim.keymap.set("n", "<M-j>", function() harpoon:list():select(2) end, { desc = "Harpoon select 2" })
vim.keymap.set("n", "<M-k>", function() harpoon:list():select(3) end, { desc = "Harpoon select 3" })
vim.keymap.set("n", "<M-l>", function() harpoon:list():select(4) end, { desc = "Harpoon select 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon select previous" })
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon select next" })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>ga", function() toggle_telescope(harpoon:list()) end,
    { desc = "Telescope [g]rep h[a]rpoon" })

vim.keymap.set("n", "<space>ht", function() toggle_telescope(harpoon:list()) end,
    { desc = "[H]arpoon [T]elescope grep" })
