-- [nfnl] lua/easilok/quit-confirm.fnl
local function starts_with(haystack, needle)
  local s = string.sub(haystack, 1, #needle)
  return (s == needle)
end
local function confirm_and_execute(cmd, opts)
  local prompt = (opts.prompt or "Are you sure?")
  local abort = (opts.abort or "Aborted")
  local function _1_(input)
    if starts_with(input, "y") then
      return vim.cmd(cmd)
    else
      return print("Aborted.")
    end
  end
  return vim.ui.input({prompt = (prompt .. " ")}, _1_)
end
local function unless_filetype_do(ignored, fn_to_run)
  local ft = vim.bo.filetype()
  if not vim.tbl_contains(ignored, ft) then
    return fn_to_run()
  else
    return nil
  end
end
local ignored_filetypes = {"gitcommit"}
local function _4_(_args)
  local ft = vim.bo.filetype
  local cmd = "x"
  if vim.tbl_contains(ignored_filetypes, ft) then
    return vim.cmd(cmd)
  else
    return confirm_and_execute(cmd, {prompt = "Are you really quitting?"})
  end
end
vim.api.nvim_create_user_command("X", _4_, {nargs = 0, desc = "Save and quit with user confirmation"})
local function _6_(_args)
  local ft = vim.bo.filetype
  local cmd = "xa"
  if vim.tbl_contains(ignored_filetypes, ft) then
    return vim.cmd(cmd)
  else
    return confirm_and_execute(cmd, {prompt = "Are you really quitting?"})
  end
end
return vim.api.nvim_create_user_command("XA", _6_, {nargs = 0, desc = "Save all files and quit with user confirmation"})
