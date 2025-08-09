-- [nfnl] after/plugin/neoformat.fnl
vim.g.neoformat_try_node_exe = 1
vim.g.neoformat_enabled_javascript = {"prettier"}
vim.g.neoformat_enabled_typescript = {"prettier"}
vim.g.neoformat_enabled_php = {"laravelpint"}
vim.g.neoformat_python_black = {exe = "black", stdin = 1, args = {"-l 120", "-q", "-"}}
return {}
