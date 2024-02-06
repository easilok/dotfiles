require("trouble").setup {}

vim.keymap.set("n", "<space>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<space>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<space>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<space>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<space>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "<space>xr", function() require("trouble").toggle("lsp_references") end)
