-- vim.opt.list = true
-- -- vim.opt.listchars:append("eol:↴")
-- vim.opt.listchars:append("tab:▸ ,eol:↴")

-- require("indent_blankline").setup {
--   show_end_of_line = true,
-- }

require("toggleterm").setup {
  -- size can be a number or function which is passed the current terminal
  open_mapping = [[\++]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  close_on_exit = true, -- close the terminal window when the process exits
}

-- require("telescope")
