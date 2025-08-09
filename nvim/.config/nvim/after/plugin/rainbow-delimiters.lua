-- [nfnl] after/plugin/rainbow-delimiters.fnl
local rainbow_delimiters = require("rainbow-delimiters")
vim.g.rainbow_delimiters = {whitelist = {"guile", "fennel", "scheme", "commonlisp", "lisp"}}
return {}
