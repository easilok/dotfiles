print("Loaded easilok")
vim.keymap.set("n", "<space>sb", "<cmd>source %<CR>", { desc = "[S]ource [b]uffer" })
-- vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "E[x]ecute selection" })
