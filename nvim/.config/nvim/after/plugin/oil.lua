local oil = require("oil")
oil.setup({
    keymaps = {
        ["<BS>"] = "actions.parent",
        ["<C-h>"] = false,
        ["<M-s>"] = "actions.select_split",
        ["<M-v>"] = "actions.select_vsplit",
    }
})

vim.keymap.set("", "<F7>", oil.open , { desc = "Open Oil file browser" })
