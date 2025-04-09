vim.keymap.set("n", "gh", "<cmd>Git log -50 --oneline<cr>", { desc = "[G]it Log [H]istory" })
vim.keymap.set("n", "g<cr>", "<cmd>Git<cr>", { desc = "[G]it" })
vim.keymap.set("n", "gb", "<cmd>Git blame<cr>", { desc = "[G]it [B]lame" })
