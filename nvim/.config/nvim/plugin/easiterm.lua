vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

local job_id = 0
vim.keymap.set("n", "<space>to", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)

  job_id = vim.bo.channel
end, { desc = "[T]erminal [o]pen on split" })

local current_command = ""
vim.keymap.set("n", "<space>ti", function()
  current_command = vim.fn.input("Command: ")
end, { desc = "[T]erminal [i]nput command" })

vim.keymap.set("n", "<space>tx", function()
  if current_command == "" then
    current_command = vim.fn.input("Command: ")
  end

  vim.fn.chansend(job_id, { current_command .. "\r\n" })
end, { desc = "[T]erminal e[x]exute command" })
