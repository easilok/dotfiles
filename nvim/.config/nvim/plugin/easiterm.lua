local M = {}

local state = {
    job_id = 0,
    term_buf = -1,
    current_command = "",
}

M.open_term_split = function(detach)
    if detach == nil then
        detach = false
    end

    vim.cmd.vnew()
    if not detach and vim.api.nvim_buf_is_valid(state.term_buf) then
        vim.api.nvim_set_current_buf(state.term_buf)
    else
        vim.cmd.term()
    end
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 20)

    if not detach then
        state.term_buf = vim.api.nvim_get_current_buf()
        state.job_id = vim.bo.channel
    end
end

vim.api.nvim_create_user_command("Easiterm", M.open_term_split, {})

vim.api.nvim_create_user_command("EasitermDetach", function() M.open_term_split(true) end, {})

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<space>tt", M.open_term_split, { desc = "[T]erminal toggle on split" })

vim.keymap.set("n", "<space>to", function() M.open_term_split(true) end, { desc = "[T]erminal [o]pen detached on split" })

vim.keymap.set("n", "<space>ti", function()
    state.current_command = vim.fn.input("Command: ")
end, { desc = "[T]erminal [i]nput command" })

vim.keymap.set("n", "<space>tx", function()
    if state.current_command == "" then
        state.current_command = vim.fn.input("Command: ")
    end

    vim.fn.chansend(state.job_id, { state.current_command .. "\r\n" })
end, { desc = "[T]erminal e[x]exute command" })

return M
