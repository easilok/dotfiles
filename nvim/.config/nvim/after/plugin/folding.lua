local opt = vim.opt

opt.foldlevel = 200
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- opt.foldtext = "nvim_treesitter#foldtext()"
-- opt.foldtext = "v:lua.vim.treesitter.foldtext()"
